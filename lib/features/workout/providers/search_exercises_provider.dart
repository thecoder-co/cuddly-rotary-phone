import 'dart:async';

import 'package:calorie_tracker/features/workout/services/workout_sync_service.dart';
import 'package:calorie_tracker/packages/packages.dart';

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
    Future.microtask(() {
      _performSync();
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
    bool more = state.hasMore;

    try {
      more = await syncService.syncPaginatedExercises(
        query: state.query,
        page: state.page,
      );
    } catch (_) {
      more = false;
    } finally {
      state = state.copyWith(isSyncing: false, hasMore: more);
    }
  }
}
