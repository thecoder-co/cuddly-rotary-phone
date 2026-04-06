import 'dart:convert';
import 'dart:developer';
import 'package:calorie_tracker/features/meals/models/meal.dart'; // SyncStatus
import 'package:calorie_tracker/features/workout/models/program.dart';
import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:calorie_tracker/features/workout/models/workout_set.dart';
import 'package:calorie_tracker/features/workout/models/workout_dto.dart';
import 'package:calorie_tracker/features/workout/repo/local_workout_repo.dart';
import 'package:calorie_tracker/features/workout/repo/workout_repo.dart';
import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workoutSyncServiceProvider = Provider((ref) {
  return WorkoutSyncService(
    localRepo: LocalWorkoutRepo(),
    cloudRepo: WorkoutCloudRepo(),
  );
});

class WorkoutSyncService {
  final LocalWorkoutRepo localRepo;
  final WorkoutCloudRepo cloudRepo;

  WorkoutSyncService({required this.localRepo, required this.cloudRepo});

  // ----- Programs -----

  Future<void> syncPendingPrograms() async {
    final pending = await localRepo.getPendingPrograms();
    for (final program in pending) {
      try {
        if (program.syncStatus == SyncStatus.pendingCreate) {
          final dto = CreateProgramDto(
            name: program.name,
            exerciseIds: program.exercises.map((e) => e.exerciseId!).toList(),
          );
          final res = await cloudRepo.createProgram(dto);
          if (res.valid && res.data != null) {
            await localRepo.isar.writeTxn(() async {
              program.syncStatus = SyncStatus.synced;
              program.backendId = res.data!.id;
              await localRepo.isar.programs.put(program);
            });
          }
        } else if (program.syncStatus == SyncStatus.pendingUpdate) {
          final dto = UpdateProgramDto(
            name: program.name,
            exerciseIds: program.exercises.map((e) => e.exerciseId!).toList(),
          );
          final res = await cloudRepo.updateProgram(program.backendId!, dto);
          if (res.valid) {
            await localRepo.isar.writeTxn(() async {
              program.syncStatus = SyncStatus.synced;
              await localRepo.isar.programs.put(program);
            });
          }
        } else if (program.syncStatus == SyncStatus.pendingDelete) {
          final res = await cloudRepo.deleteProgram(program.backendId!);
          if (res.valid || (!res.isNetworkError && res.statusCode == 404)) {
            await localRepo.deleteProgram(program.id);
          }
        }
      } catch (e) {
        log('Error syncing program ${program.id}: $e');
      }
    }
  }

  Future<void> syncAllPrograms() async {
    try {
      final res = await cloudRepo.getPrograms();
      if (!res.valid || res.data == null) return;

      await localRepo.isar.writeTxn(() async {
        for (final p in res.data!) {
          final backendId = p.id;
          if (backendId == null) continue;

          final existing = await localRepo.getProgramByBackendId(backendId);
          if (existing != null && existing.syncStatus != SyncStatus.synced) {
            continue;
          }

          final isarProgram = existing ?? Program();
          isarProgram.backendId = backendId;
          isarProgram.name = p.name;
          isarProgram.userId = p.userId;
          isarProgram.createdAt = p.createdAt;
          isarProgram.updatedAt = p.updatedAt;
          isarProgram.syncStatus = SyncStatus.synced;

          if (p.exercises != null) {
            isarProgram.exercises = p.exercises!.map((e) {
              return ProgramExercise(
                backendId: e.id,
                exerciseId: e.exerciseId ?? e.exercise?.id,
                order: e.order,
              );
            }).toList();
          }

          await localRepo.isar.programs.put(isarProgram);
        }
      });
    } catch (_) {}
  }

  // ----- Exercises -----

  Future<void> syncPendingExercises() async {
    final pending = await localRepo.getPendingExercises();

    // 1. Bulk Add from parent
    final parentAdds = pending
        .where((e) => e.syncStatus == SyncStatus.pendingAddFromParent)
        .toList();
    if (parentAdds.isNotEmpty) {
      try {
        final ids = parentAdds
            .map((e) => e.backendId)
            .where((id) => id != null)
            .cast<String>()
            .toList();
        if (ids.isNotEmpty) {
          final res = await cloudRepo.addExercisesFromParent(
            AddExercisesDto(exerciseIds: ids),
          );
          if (res.valid) {
            await localRepo.isar.writeTxn(() async {
              for (final e in parentAdds) {
                e.syncStatus = SyncStatus.synced;
                await localRepo.isar.exercises.put(e);
              }
            });
          }
        }
      } catch (e) {
        log('Error bulk adding from parent: $e');
      }
    }

    // 2. Individual Create/Update/Delete
    for (final exercise in pending) {
      // Skip handled bulk adds

      try {
        if (exercise.syncStatus == SyncStatus.pendingAddFromParent) {
          continue;
        } else if (exercise.syncStatus == SyncStatus.pendingCreate) {
          final dto = CreateExerciseDto(
            name: exercise.name,
            description: exercise.description,
            oneRmFormula: exercise.oneRmFormula,
          );
          final res = await cloudRepo.createExercise(dto);
          if (res.valid && res.data != null) {
            await localRepo.isar.writeTxn(() async {
              exercise.syncStatus = SyncStatus.synced;
              exercise.backendId = res.data!.id;
              await localRepo.isar.exercises.put(exercise);
            });
          }
        } else if (exercise.syncStatus == SyncStatus.pendingUpdate) {
          final dto = CreateExerciseDto(
            name: exercise.name,
            description: exercise.description,
            oneRmFormula: exercise.oneRmFormula,
          );
          final res = await cloudRepo.updateExercise(exercise.backendId!, dto);
          if (res.valid) {
            await localRepo.isar.writeTxn(() async {
              exercise.syncStatus = SyncStatus.synced;
              await localRepo.isar.exercises.put(exercise);
            });
          }
        } else if (exercise.syncStatus == SyncStatus.pendingDelete) {
          // Note: Backend endpoint for exercise deletion may not exist yet,
          // we log or skip for now while keeping the local status.
        }
      } catch (e) {
        log('Error syncing exercise ${exercise.id}: $e');
      }
    }
  }

  Future<void> localAddExercisesFromParent(List<String> exerciseIds) async {
    await localRepo.isar.writeTxn(() async {
      for (final backendId in exerciseIds) {
        final existing = await localRepo.getExerciseByBackendId(backendId);
        if (existing != null) {
          existing.syncStatus = SyncStatus.pendingAddFromParent;
          existing.ownerId = LocalData.userId;

          await localRepo.isar.exercises.put(existing);
        }
      }
    });
    // Trigger background sync
    syncPendingExercises();
  }

  Future<void> syncExercises() async {
    try {
      final res = await cloudRepo.getMyExercises();
      if (!res.valid || res.data == null) return;

      await localRepo.isar.writeTxn(() async {
        for (final p in res.data!) {
          final backendId = p.id;
          if (backendId == null) continue;

          final existing = await localRepo.getExerciseByBackendId(backendId);
          if (existing != null && existing.syncStatus != SyncStatus.synced) {
            continue;
          }

          final isarExercise = existing ?? Exercise();
          isarExercise.backendId = backendId;
          isarExercise.name = p.name;
          if (p.jsonDesc != null) {
            isarExercise.jsonDesc = json.encode(p.jsonDesc);
          }
          isarExercise.images = p.images;
          isarExercise.popularity = p.popularity;
          isarExercise.ownerId = LocalData.userId;
          isarExercise.oneRmFormula = p.oneRmFormula;
          isarExercise.description = p.description;
          isarExercise.createdAt = p.createdAt;
          isarExercise.updatedAt = p.updatedAt;
          isarExercise.localSetsCount = p.count?.sets;
          isarExercise.syncStatus = SyncStatus.synced;

          await localRepo.isar.exercises.put(isarExercise);
        }
      });
    } catch (_) {}
  }

  Future<bool> syncPaginatedExercises({
    String? query,
    int page = 1,
    int limit = 100,
  }) async {
    bool hasMore = false;
    try {
      final res = await cloudRepo.getPaginatedExercises(
        name: query,
        page: page,
        limit: limit,
      );
      if (!res.valid || res.data == null || res.data!.data == null) {
        return false;
      }

      final pageData = res.data!;
      hasMore = (pageData.page ?? 1) < (pageData.totalPages ?? 1);

      await localRepo.isar.writeTxn(() async {
        for (final p in res.data!.data!) {
          final backendId = p.id;
          if (backendId == null) continue;

          final existing = await localRepo.getExerciseByBackendId(backendId);
          if (existing != null && existing.syncStatus != SyncStatus.synced) {
            continue;
          }

          final isarExercise = existing ?? Exercise();
          isarExercise.backendId = backendId;
          isarExercise.name = p.name;
          isarExercise.popularity = p.popularity;
          if (p.jsonDesc != null) {
            isarExercise.jsonDesc = json.encode(p.jsonDesc);
          }
          isarExercise.images = p.images;

          if (isarExercise.ownerId != LocalData.userId) {
            isarExercise.ownerId = p.ownerId;
          }
          isarExercise.oneRmFormula = p.oneRmFormula;
          isarExercise.description = p.description;
          isarExercise.createdAt = p.createdAt;
          isarExercise.updatedAt = p.updatedAt;
          isarExercise.localSetsCount = p.count?.sets;
          isarExercise.syncStatus = SyncStatus.synced;

          await localRepo.isar.exercises.put(isarExercise);
        }
      });
    } catch (_) {}
    return hasMore;
  }

  // ----- Sets -----

  Future<void> syncPendingWorkoutSets() async {
    final pending = await localRepo.getPendingWorkoutSets();
    for (final set in pending) {
      try {
        if (set.syncStatus == SyncStatus.pendingCreate) {
          final dto = CreateWorkoutSetDto(
            exerciseId: set.exerciseId,
            reps: set.reps,

            weight: set.weight,
            comment: set.comment,
          );
          final res = await cloudRepo.createSet(dto);
          if (res.valid && res.data != null) {
            await localRepo.isar.writeTxn(() async {
              set.syncStatus = SyncStatus.synced;
              set.backendId = res.data!.id;
              await localRepo.isar.workoutSets.put(set);
            });
          }
        } else if (set.syncStatus == SyncStatus.pendingUpdate) {
          final dto = UpdateWorkoutSetDto(
            reps: set.reps,
            weight: set.weight,
            comment: set.comment,
            date: set.date,
          );
          final res = await cloudRepo.updateSet(set.backendId!, dto);
          if (res.valid) {
            await localRepo.isar.writeTxn(() async {
              set.syncStatus = SyncStatus.synced;
              await localRepo.isar.workoutSets.put(set);
            });
          }
        } else if (set.syncStatus == SyncStatus.pendingDelete) {
          final res = await cloudRepo.deleteSet(set.backendId!);
          if (res.valid || (!res.isNetworkError && res.statusCode == 404)) {
            await localRepo.deleteWorkoutSet(set.id);
          }
        }
      } catch (e) {
        log('Error syncing workout set ${set.id}: $e');
      }
    }
  }

  Future<void> syncWorkoutSets({String? exerciseId, int page = 1}) async {
    try {
      final res = await cloudRepo.getSets(exerciseId: exerciseId, page: page);
      if (!res.valid || res.data == null || res.data!.data == null) return;

      await localRepo.isar.writeTxn(() async {
        for (final s in res.data!.data!) {
          final backendId = s.id;
          if (backendId == null) continue;

          final existing = await localRepo.getWorkoutSetByBackendId(backendId);
          // Preserve local pending changes
          if (existing != null &&
              (existing.syncStatus == SyncStatus.pendingUpdate ||
                  existing.syncStatus == SyncStatus.pendingDelete)) {
            continue;
          }

          final isarSet = existing ?? WorkoutSet();
          isarSet.backendId = backendId;
          isarSet.exerciseId = s.exerciseId;
          isarSet.reps = s.reps;
          isarSet.weight = s.weight;
          isarSet.comment = s.comment;
          isarSet.date = s.date ?? s.createdAt;
          isarSet.syncStatus = SyncStatus.synced;

          await localRepo.isar.workoutSets.put(isarSet);
        }
      });
    } catch (_) {}
  }
}
