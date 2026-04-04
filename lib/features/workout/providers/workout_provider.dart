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
      await syncService.syncExercises(onlyMy);
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
      });

      return localRepo.watchWorkoutSetsForExercise(exerciseBackendId);
    });

// ----- Notifiers -----

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

final workoutSetProvider = AsyncNotifierProvider.autoDispose
    .family<WorkoutSetNotifier, List<WorkoutSet>, String>(
      WorkoutSetNotifier.new,
    );

class WorkoutSetNotifier extends AsyncNotifier<List<WorkoutSet>> {
  final String arg;
  WorkoutSetNotifier(this.arg);
  @override
  FutureOr<List<WorkoutSet>> build() async {
    return await ref.watch(isarWorkoutSetsStreamProvider(arg).future);
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

final searchExercisesProvider =
    NotifierProvider.autoDispose<SearchExercisesNotifier, SearchState>(
      SearchExercisesNotifier.new,
    );

class SearchState {
  final String query;
  final int page;
  final bool isSyncing;
  final bool hasMore;

  SearchState({
    this.query = '',
    this.page = 1,
    this.isSyncing = false,
    this.hasMore = true,
  });

  SearchState copyWith({
    String? query,
    int? page,
    bool? isSyncing,
    bool? hasMore,
  }) {
    return SearchState(
      query: query ?? this.query,
      page: page ?? this.page,
      isSyncing: isSyncing ?? this.isSyncing,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class SearchExercisesNotifier extends Notifier<SearchState> {
  Timer? _debounce;

  @override
  SearchState build() {
    ref.onDispose(() {
      _debounce?.cancel();
    });
    return SearchState();
  }

  void updateQuery(String query) {
    if (state.query == query) return;
    state = state.copyWith(query: query, page: 1, hasMore: true);

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSync();
    });
  }

  Future<void> loadMore() async {
    if (state.isSyncing || !state.hasMore) return;
    state = state.copyWith(page: state.page + 1);
    await _performSync();
  }

  Future<void> _performSync() async {
    state = state.copyWith(isSyncing: true);
    final syncService = ref.read(workoutSyncServiceProvider);

    try {
      await syncService.syncPaginatedExercises(
        query: state.query,
        page: state.page,
        limit: 20,
      );
    } catch (_) {
    } finally {
      state = state.copyWith(isSyncing: false);
    }
  }
}
