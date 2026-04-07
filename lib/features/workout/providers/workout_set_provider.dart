import 'dart:async';

import 'package:calorie_tracker/features/meals/models/meal.dart';
import 'package:calorie_tracker/features/workout/models/workout_set.dart';
import 'package:calorie_tracker/features/workout/presentation/widgets/record_set_sheet.dart';
import 'package:calorie_tracker/features/workout/providers/timer_provider.dart';
import 'package:calorie_tracker/features/workout/providers/workout_provider.dart';
import 'package:calorie_tracker/features/workout/services/workout_sync_service.dart';
import 'package:calorie_tracker/packages/packages.dart';

final workoutSetProvider = AsyncNotifierProvider.autoDispose
    .family<WorkoutSetNotifier, List<WorkoutSet>, String>(
      WorkoutSetNotifier.new,
    );

class WorkoutSetNotifier extends AsyncNotifier<List<WorkoutSet>> {
  final String arg;
  WorkoutSetNotifier(this.arg);
  @override
  FutureOr<List<WorkoutSet>> build() {
    final asyncData = ref.watch(isarWorkoutSetsStreamProvider(arg));
    if (asyncData.hasValue) {
      return asyncData.requireValue;
    }
    return ref.watch(isarWorkoutSetsStreamProvider(arg).future);
  }

  void showAddSetModal(
    String exerciseName,
    String backendId, [
    WorkoutSet? prefillFrom,
  ]) {
    final initialWeight = prefillFrom?.weight ?? 20.0;
    final initialReps = prefillFrom?.reps ?? 10;

    showModalBottomSheet(
      context: NavigationService.context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return RecordSetSheet(
          initialWeight: initialWeight,
          initialReps: initialReps,
          onSave: (weight, reps) {
            final newSet = WorkoutSet()
              ..exerciseId = backendId
              ..weight = weight
              ..reps = reps
              ..date = DateTime.now();

            addSet(newSet);
            ref
                .read(workoutTimerProvider.notifier)
                .startTimer(exerciseName: exerciseName);

            Navigator.pop(context);
          },
        );
      },
    );
  }

  Future<void> addSet(WorkoutSet set) async {
    set.syncStatus = SyncStatus.pendingCreate;
    set.backendId = 'local_${DateTime.now().microsecondsSinceEpoch}';
    final localRepo = ref.read(localWorkoutRepoProvider);
    await localRepo.saveWorkoutSet(set);
    ref.read(workoutSyncServiceProvider).syncPendingWorkoutSets();
  }

  Future<void> updateSet(WorkoutSet set, String? id) async {
    final isLocalId = id != null && id.startsWith('local_');
    set.syncStatus = (id == null || isLocalId)
        ? SyncStatus.pendingCreate
        : SyncStatus.pendingUpdate;
    set.backendId = id;
    final localRepo = ref.read(localWorkoutRepoProvider);
    await localRepo.saveWorkoutSet(set);
    ref.read(workoutSyncServiceProvider).syncPendingWorkoutSets();
  }

  Future<void> deleteSet(WorkoutSet set, String? id) async {
    final localRepo = ref.read(localWorkoutRepoProvider);
    if (id == null || id.startsWith('local_')) {
      await localRepo.deleteWorkoutSet(set.id);
      return;
    }
    set.syncStatus = SyncStatus.pendingDelete;
    await localRepo.saveWorkoutSet(set);
    ref.read(workoutSyncServiceProvider).syncPendingWorkoutSets();
  }
}
