import 'package:calorie_tracker/core/providers/theme_provider.dart';
import 'package:calorie_tracker/features/workout/providers/search_exercises_provider.dart';
import 'package:calorie_tracker/features/workout/providers/workout_provider.dart';
import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExerciseScreen extends ConsumerStatefulWidget {
  final List<String> initialSelectedIds;

  const AddExerciseScreen({super.key, this.initialSelectedIds = const []});

  @override
  ConsumerState<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends ConsumerState<AddExerciseScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<String> _selectedExerciseIds = [];
  final Set<String> _lockedIds = {};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _selectedExerciseIds.addAll(widget.initialSelectedIds);
    _lockedIds.addAll(widget.initialSelectedIds);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(searchExercisesProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchExercisesProvider);
    final exercisesAsync = ref.watch(isarExercisesStreamProvider(false));
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;
    return Material(
      type: MaterialType.transparency,
      child: CupertinoPageScaffold(
        backgroundColor: isDark ? CupertinoColors.black : Colors.white,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: isDark ? CupertinoColors.black : Colors.white,
          border: null,
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(
              CupertinoIcons.chevron_back,
              color: CupertinoColors.systemGreen,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          middle: Text(
            'Add Exercise',
            style: TextStyle(
              color: isDark ? CupertinoColors.white : Colors.black,
            ),
          ),
          trailing: const Icon(
            CupertinoIcons.square_grid_2x2,
            color: CupertinoColors.systemGrey,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoSearchTextField(
                        controller: _searchController,
                        placeholder: 'Search or enter exercise name...',
                        backgroundColor: isDark
                            ? const Color(0xFF1C1C1E)
                            : CupertinoColors.systemGroupedBackground,
                        style: TextStyle(
                          color: isDark ? CupertinoColors.white : Colors.black,
                        ),
                        placeholderStyle: TextStyle(
                          color: isDark
                              ? CupertinoColors.systemGrey
                              : Colors.black,
                        ),
                        itemColor: CupertinoColors.systemGreen,
                        onChanged: (value) {
                          ref
                              .read(searchExercisesProvider.notifier)
                              .updateQuery(value);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text(
                        'Create',
                        style: TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () => _createExercise(_searchController.text),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Popularity',
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildPopularityIndicator(0.8, size: 16, isHeader: true),
                  ],
                ),
              ),
              Expanded(
                child: exercisesAsync.when(
                  data: (allExercises) {
                    final query = searchState.query.toLowerCase();
                    final filtered = allExercises.where((e) {
                      final name = e.name?.toLowerCase() ?? '';
                      return name.contains(query);
                    }).toList();

                    filtered.sort(
                      (a, b) =>
                          (b.popularity ?? 0).compareTo(a.popularity ?? 0),
                    );

                    if (filtered.isEmpty && !searchState.isSyncing) {
                      return const Center(
                        child: Text(
                          'No exercises found',
                          style: TextStyle(color: CupertinoColors.systemGrey),
                        ),
                      );
                    }

                    return ListView.separated(
                      controller: _scrollController,
                      itemCount:
                          filtered.length + (searchState.isSyncing ? 1 : 0),
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: isDark
                            ? Colors.grey.shade900
                            : Colors.grey.shade200,
                        indent: 50,
                      ),
                      itemBuilder: (context, index) {
                        if (index == filtered.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CupertinoActivityIndicator()),
                          );
                        }

                        final exercise = filtered[index];
                        final id = exercise.backendId ?? exercise.id.toString();
                        final isSelected = _selectedExerciseIds.contains(id);
                        final isLocked = _lockedIds.contains(id);

                        return CupertinoListTile(
                          backgroundColor: CupertinoColors.transparent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          leading: isSelected
                              ? Icon(
                                  CupertinoIcons.check_mark,
                                  color: isLocked
                                      ? isDark
                                            ? CupertinoColors.systemGrey
                                                  .withValues(alpha: 0.5)
                                            : CupertinoColors.systemGreen
                                      : CupertinoColors.systemGreen,
                                  size: 18,
                                )
                              : const SizedBox(width: 18),
                          title: Text(
                            exercise.name ?? 'Unnamed',
                            style: TextStyle(
                              color: isLocked
                                  ? isDark
                                        ? CupertinoColors.systemGrey.withValues(
                                            alpha: 0.5,
                                          )
                                        : CupertinoColors.systemGreen
                                  : isDark
                                  ? CupertinoColors.white
                                  : CupertinoColors.black,
                              fontSize: 16,
                            ),
                          ),
                          trailing: _buildPopularityIndicator(
                            (exercise.popularity ?? 0) / 100,
                            size: 24,
                          ),
                          onTap: isLocked
                              ? null
                              : () {
                                  setState(() {
                                    if (_selectedExerciseIds.contains(id)) {
                                      _selectedExerciseIds.remove(id);
                                    } else {
                                      _selectedExerciseIds.add(id);
                                    }
                                  });
                                },
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CupertinoActivityIndicator()),
                  error: (err, stack) => Center(
                    child: Text(
                      'Error: $err',
                      style: const TextStyle(color: CupertinoColors.systemRed),
                    ),
                  ),
                ),
              ),
              if (_selectedExerciseIds.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      onPressed: () {
                        final exercises =
                            ref
                                .read(isarExercisesStreamProvider(false))
                                .value ??
                            [];
                        final selected = exercises.where((e) {
                          final id = e.backendId ?? e.id.toString();
                          // Only return newly selected exercises, or keep the original logic if that's preferred.
                          // Usually, such screens return the FULL list of what should be in the selection.
                          return _selectedExerciseIds.contains(id);
                        }).toList();
                        Navigator.pop(context, selected);
                      },
                      child: const Text('Add Selected'),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularityIndicator(
    double value, {
    double size = 24,
    bool isHeader = false,
  }) {
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark
                    ? const Color(0xFF2C2C2E)
                    : CupertinoColors.systemGrey,
                width: isHeader ? 2 : 3,
              ),
            ),
          ),
          CircularProgressIndicator(
            value: value,
            strokeWidth: isHeader ? 2 : 3,
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation<Color>(
              isHeader
                  ? CupertinoColors.systemGrey
                  : CupertinoColors.systemGreen,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createExercise(String name) async {
    if (name.isEmpty) return;

    final exercise = Exercise()
      ..name = name
      ..popularity = 0
      ..updatedAt = DateTime.now()
      ..createdAt = DateTime.now();

    await ref
        .read(workoutExerciseProvider(false).notifier)
        .addExercise(exercise);
  }
}
