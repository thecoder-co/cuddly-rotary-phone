import 'package:calorie_tracker/core/services/local_data/isar_service.dart';
import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/features/meals/models/meal.dart'; // SyncStatus
import 'package:calorie_tracker/features/workout/models/program.dart';
import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:calorie_tracker/features/workout/models/workout_set.dart';
import 'package:isar_community/isar.dart';

class LocalWorkoutRepo {
  final Isar isar;

  LocalWorkoutRepo({Isar? isarInstance})
    : isar = isarInstance ?? IsarService.isar;

  // ----- Programs -----

  Future<int> saveProgram(Program program) async {
    return await isar.writeTxn(() async {
      return await isar.programs.put(program);
    });
  }

  Future<void> deleteProgram(int id) async {
    await isar.writeTxn(() async {
      await isar.programs.delete(id);
    });
  }

  Future<Program?> getProgram(int id) async {
    return await isar.programs.get(id);
  }

  Future<Program?> getProgramByBackendId(String backendId) async {
    return await isar.programs.getByBackendId(backendId);
  }

  Stream<List<Program>> watchPrograms() async* {
    final stream = isar.programs.watchLazy(fireImmediately: true);
    await for (final _ in stream) {
      yield await isar.programs
          .filter()
          .not()
          .syncStatusEqualTo(SyncStatus.pendingDelete)
          .findAll();
    }
  }

  Future<List<Program>> getPendingPrograms() async {
    return await isar.programs
        .filter()
        .syncStatusEqualTo(SyncStatus.pendingCreate)
        .or()
        .syncStatusEqualTo(SyncStatus.pendingUpdate)
        .or()
        .syncStatusEqualTo(SyncStatus.pendingDelete)
        .findAll();
  }

  // ----- Exercises -----

  Future<int> saveExercise(Exercise exercise) async {
    return await isar.writeTxn(() async {
      return await isar.exercises.put(exercise);
    });
  }

  Future<void> deleteExercise(int id) async {
    await isar.writeTxn(() async {
      await isar.exercises.delete(id);
    });
  }

  Future<Exercise?> getExercise(int id) async {
    return await isar.exercises.get(id);
  }

  Future<Exercise?> getExerciseByBackendId(String backendId) async {
    return await isar.exercises.getByBackendId(backendId);
  }

  Stream<List<Exercise>> watchExercises(bool onlyMy) async* {
    final stream = isar.exercises.watchLazy(fireImmediately: true);
    await for (final _ in stream) {
      var query = isar.exercises
          .filter()
          .not()
          .syncStatusEqualTo(SyncStatus.pendingDelete)
          .sortByPopularityDesc();
      if (onlyMy) {
        query = isar.exercises
            .filter()
            .not()
            .syncStatusEqualTo(SyncStatus.pendingDelete)
            .ownerIdEqualTo(LocalData.userId)
            .sortByPopularityDesc();
      }
      yield await query.findAll();
    }
  }

  Future<List<Exercise>> getPendingExercises() async {
    return await isar.exercises
        .filter()
        .syncStatusEqualTo(SyncStatus.pendingCreate)
        .or()
        .syncStatusEqualTo(SyncStatus.pendingUpdate)
        .or()
        .syncStatusEqualTo(SyncStatus.pendingDelete)
        .or()
        .syncStatusEqualTo(SyncStatus.pendingAddFromParent)
        .findAll();
  }

  // ----- Workout Sets -----

  Future<int> saveWorkoutSet(WorkoutSet set) async {
    return await isar.writeTxn(() async {
      return await isar.workoutSets.put(set);
    });
  }

  Future<void> deleteWorkoutSet(int id) async {
    await isar.writeTxn(() async {
      await isar.workoutSets.delete(id);
    });
  }

  Future<WorkoutSet?> getWorkoutSet(int id) async {
    return await isar.workoutSets.get(id);
  }

  Future<WorkoutSet?> getWorkoutSetByBackendId(String backendId) async {
    return await isar.workoutSets.getByBackendId(backendId);
  }

  Future<List<WorkoutSet>> getWorkoutSetsForExercise(
    String exerciseBackendId,
  ) async {
    return await isar.workoutSets
        .filter()
        .exerciseIdEqualTo(exerciseBackendId)
        .not()
        .syncStatusEqualTo(SyncStatus.pendingDelete)
        .findAll();
  }

  Stream<List<WorkoutSet>> watchWorkoutSetsForExercise(
    String exerciseBackendId,
  ) async* {
    final stream = isar.workoutSets.watchLazy(fireImmediately: true);
    await for (final _ in stream) {
      yield await isar.workoutSets
          .filter()
          .exerciseIdEqualTo(exerciseBackendId)
          .not()
          .syncStatusEqualTo(SyncStatus.pendingDelete)
          .sortByDate()
          .findAll();
    }
  }

  Future<List<WorkoutSet>> getPendingWorkoutSets() async {
    return await isar.workoutSets
        .filter()
        .syncStatusEqualTo(SyncStatus.pendingCreate)
        .or()
        .syncStatusEqualTo(SyncStatus.pendingUpdate)
        .or()
        .syncStatusEqualTo(SyncStatus.pendingDelete)
        .findAll();
  }
}
