import 'dart:async';
import 'package:calorie_tracker/features/meals/models/meal.dart'; // SyncStatus
import 'package:calorie_tracker/features/workout/models/program.dart';
import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:calorie_tracker/features/workout/models/workout_set.dart';
import 'package:calorie_tracker/features/workout/repo/local_workout_repo.dart';
import 'package:calorie_tracker/features/workout/services/workout_sync_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localWorkoutRepoProvider = Provider((ref) => LocalWorkoutRepo());

// ----- Stream Providers -----

final isarProgramsStreamProvider = StreamProvider<List<Program>>((ref) {
  final localRepo = ref.watch(localWorkoutRepoProvider);
  final syncService = ref.read(workoutSyncServiceProvider);

  Future(() async {
    await syncService.syncPendingPrograms();
    await syncService.syncAllPrograms();
  });

  return localRepo.watchPrograms();
});

final isarExercisesStreamProvider = StreamProvider.family<List<Exercise>, bool>(
  (ref, onlyMy) {
    final localRepo = ref.watch(localWorkoutRepoProvider);
    final syncService = ref.read(workoutSyncServiceProvider);

    Future(() async {
      await syncService.syncPendingExercises();
      await syncService.syncExercises();
    });

    return localRepo.watchExercises(onlyMy);
  },
);

final isarWorkoutSetsStreamProvider =
    StreamProvider.family<List<WorkoutSet>, String>((ref, exerciseBackendId) {
      final localRepo = ref.watch(localWorkoutRepoProvider);
      final syncService = ref.read(workoutSyncServiceProvider);

      Future(() async {
        await syncService.syncPendingWorkoutSets();
        Future.microtask(() {
          syncService.syncWorkoutSets(exerciseId: exerciseBackendId);
        });
      });

      return localRepo.watchWorkoutSetsForExercise(exerciseBackendId);
    });

final workoutSelectedDateProvider =
    NotifierProvider<WorkoutSelectedDateNotifier, DateTime>(
      WorkoutSelectedDateNotifier.new,
    );

class WorkoutSelectedDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => DateTime.now();

  void setDate(DateTime date) => state = date;

  @override
  set state(DateTime value) => super.state = value;
}

final isarWorkoutSetsByDateStreamProvider =
    StreamProvider.family<List<WorkoutSet>, DateTime>((ref, date) {
      final localRepo = ref.watch(localWorkoutRepoProvider);
      final syncService = ref.read(workoutSyncServiceProvider);

      Future(() async {
        await syncService.syncPendingWorkoutSets();
        // Sync all sets globally to ensure we have data for the selected date
        syncService.syncWorkoutSets();
      });

      return localRepo.watchWorkoutSetsForDate(date);
    });

// ----- Notifiers -----

// arg is isMine
final workoutExerciseProvider = AsyncNotifierProvider.autoDispose
    .family<WorkoutExerciseNotifier, List<Exercise>, bool>(
      WorkoutExerciseNotifier.new,
    );

class WorkoutExerciseNotifier extends AsyncNotifier<List<Exercise>> {
  final bool arg;
  WorkoutExerciseNotifier(this.arg);
  @override
  FutureOr<List<Exercise>> build() async {
    return await ref.watch(isarExercisesStreamProvider(arg).future);
  }

  Future<void> addExercise(Exercise exercise) async {
    exercise.syncStatus = SyncStatus.pendingCreate;
    exercise.backendId = 'local_${DateTime.now().microsecondsSinceEpoch}';
    final localRepo = ref.read(localWorkoutRepoProvider);
    await localRepo.saveExercise(exercise);
    ref.read(workoutSyncServiceProvider).syncPendingExercises();
  }

  Future<void> updateExercise(Exercise exercise, String? id) async {
    final isLocalId = id != null && id.startsWith('local_');
    exercise.syncStatus = (id == null || isLocalId)
        ? SyncStatus.pendingCreate
        : SyncStatus.pendingUpdate;
    exercise.backendId = id;
    final localRepo = ref.read(localWorkoutRepoProvider);
    await localRepo.saveExercise(exercise);
    ref.read(workoutSyncServiceProvider).syncPendingExercises();
  }

  Future<void> deleteExercise(Exercise exercise, String? id) async {
    final localRepo = ref.read(localWorkoutRepoProvider);
    if (id == null || id.startsWith('local_')) {
      await localRepo.deleteExercise(exercise.id);
      return;
    }
    exercise.syncStatus = SyncStatus.pendingDelete;
    await localRepo.saveExercise(exercise);
    ref.read(workoutSyncServiceProvider).syncPendingExercises();
  }
}
