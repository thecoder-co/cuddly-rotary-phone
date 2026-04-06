import 'dart:async';

import 'package:calorie_tracker/features/meals/models/meal.dart';
import 'package:calorie_tracker/features/workout/models/workout_set.dart';
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
