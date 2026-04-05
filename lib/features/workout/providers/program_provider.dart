import 'dart:async';

import 'package:calorie_tracker/features/meals/models/meal.dart';
import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:calorie_tracker/features/workout/models/program.dart';
import 'package:calorie_tracker/features/workout/providers/workout_provider.dart';
import 'package:calorie_tracker/features/workout/services/workout_sync_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workoutProgramProvider =
    AsyncNotifierProvider.autoDispose<WorkoutProgramNotifier, List<Program>>(
      WorkoutProgramNotifier.new,
    );

class WorkoutProgramNotifier extends AsyncNotifier<List<Program>> {
  @override
  FutureOr<List<Program>> build() async {
    return await ref.watch(isarProgramsStreamProvider.future);
  }

  Future<void> addProgram(Program program) async {
    program.syncStatus = SyncStatus.pendingCreate;
    program.backendId = 'local_${DateTime.now().microsecondsSinceEpoch}';
    final localRepo = ref.read(localWorkoutRepoProvider);
    await localRepo.saveProgram(program);
    ref.read(workoutSyncServiceProvider).syncPendingPrograms();
  }

  Future<void> updateProgram(Program program, String? id) async {
    final isLocalId = id != null && id.startsWith('local_');
    program.syncStatus = (id == null || isLocalId)
        ? SyncStatus.pendingCreate
        : SyncStatus.pendingUpdate;
    program.backendId = id;
    final localRepo = ref.read(localWorkoutRepoProvider);
    await localRepo.saveProgram(program);
    ref.read(workoutSyncServiceProvider).syncPendingPrograms();
  }

  Future<void> deleteProgram(Program program, String? id) async {
    final localRepo = ref.read(localWorkoutRepoProvider);
    if (id == null || id.startsWith('local_')) {
      await localRepo.deleteProgram(program.id);
      return;
    }
    program.syncStatus = SyncStatus.pendingDelete;
    await localRepo.saveProgram(program);
    ref.read(workoutSyncServiceProvider).syncPendingPrograms();
  }
}

final workoutProgramExerciseProvider =
    Provider.family<AsyncValue<List<Exercise>>, int>((ref, programId) {
      final programsAsync = ref.watch(isarProgramsStreamProvider);
      final exercisesAsync = ref.watch(isarExercisesStreamProvider(false));

      return programsAsync.when(
        data: (programs) {
          final program = programs.firstWhere(
            (p) => p.id == programId,
            orElse: () => Program()..name = 'Program Not Found',
          );

          if (program.name == 'Program Not Found') {
            return const AsyncValue.data([]);
          }

          return exercisesAsync.when(
            data: (exercises) {
              final mapped = program.exercises
                  .map((pe) {
                    return exercises.firstWhere(
                      (e) =>
                          e.backendId == pe.exerciseId ||
                          e.id.toString() == pe.exerciseId,
                      orElse: () => Exercise(name: 'Unknown Exercise'),
                    );
                  })
                  .where((e) => e.name != 'Unknown Exercise')
                  .toList();
              return AsyncValue.data(mapped);
            },
            loading: () => const AsyncValue.loading(),
            error: (e, s) => AsyncValue.error(e, s),
          );
        },
        loading: () => const AsyncValue.loading(),
        error: (e, s) => AsyncValue.error(e, s),
      );
    });
