import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:calorie_tracker/features/workout/models/workout_set.dart';
import 'package:calorie_tracker/features/workout/presentation/edit_set_screen.dart';
import 'package:calorie_tracker/features/workout/presentation/widgets/exercise_set_tile.dart';
import 'package:calorie_tracker/features/workout/providers/workout_provider.dart';
import 'package:calorie_tracker/features/meals_home_page/presentation/widgets/date_selector.dart';
import 'package:calorie_tracker/features/workout/providers/workout_set_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class WorkoutAnalyticsScreen extends ConsumerStatefulWidget {
  const WorkoutAnalyticsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WorkoutAnalyticsScreenState();
}

class _WorkoutAnalyticsScreenState
    extends ConsumerState<WorkoutAnalyticsScreen> {
  String _formatDateForTitle(DateTime date) {
    final now = DateTime.now();
    final d = DateTime(date.year, date.month, date.day);
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (d.isAtSameMomentAs(today)) return 'Today';
    if (d.isAtSameMomentAs(yesterday)) return 'Yesterday';

    if (date.year == now.year) {
      return DateFormat('d MMMM').format(date);
    } else {
      return DateFormat('d MMM, yyyy').format(date);
    }
  }

  Map<String, List<WorkoutSet>> _groupSetsByExercise(List<WorkoutSet> sets) {
    final groups = <String, List<WorkoutSet>>{};
    for (var set in sets) {
      final exerciseId = set.exerciseId ?? 'unknown';
      groups.putIfAbsent(exerciseId, () => []).add(set);
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(workoutSelectedDateProvider);
    final setsAsync = ref.watch(
      isarWorkoutSetsByDateStreamProvider(selectedDate),
    );
    final exercisesAsync = ref.watch(workoutExerciseProvider(false));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoPageScaffold(
      backgroundColor: isDark
          ? CupertinoColors.black
          : CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.06),
            width: 0.5,
          ),
        ),
        middle: Text(
          _formatDateForTitle(selectedDate),
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: DateSelector(
                  initialDate: selectedDate,
                  onDateSelected: (date) {
                    ref
                        .read(workoutSelectedDateProvider.notifier)
                        .setDate(date);
                  },
                ),
              ),
              Expanded(
                child: setsAsync.when(
                  data: (sets) {
                    if (sets.isEmpty) {
                      return const Center(
                        child: Text(
                          'No workouts recorded for this day',
                          style: TextStyle(color: CupertinoColors.systemGrey),
                        ),
                      );
                    }

                    final grouped = _groupSetsByExercise(sets);

                    return exercisesAsync.when(
                      data: (exercises) {
                        final exerciseMap = {
                          for (var e in exercises)
                            e.backendId ?? e.id.toString(): e,
                        };

                        return ListView.builder(
                          padding: const EdgeInsets.only(bottom: 24),
                          itemCount: grouped.length,
                          itemBuilder: (context, index) {
                            final exerciseId = grouped.keys.elementAt(index);
                            final daySets = grouped[exerciseId]!;
                            final exercise =
                                exerciseMap[exerciseId] ??
                                Exercise(name: 'Unknown Exercise');

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      top: 8,
                                      bottom: 8,
                                    ),
                                    child: Text(
                                      exercise.name?.toUpperCase() ?? 'UNKNOWN',
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade600,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? const Color(0xFF1C1C1E)
                                            : CupertinoColors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        children: daySets.asMap().entries.map((
                                          entry,
                                        ) {
                                          final idx = entry.key;
                                          final set = entry.value;
                                          return Column(
                                            children: [
                                              if (idx > 0)
                                                Divider(
                                                  height: 1,
                                                  color: isDark
                                                      ? Colors.grey.shade800
                                                      : Colors.grey.shade200,
                                                ),
                                              ExerciseSetTile(
                                                workoutSet: set,
                                                onEdit: () {
                                                  Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                      builder: (context) =>
                                                          EditSetScreen(
                                                            exercise: exercise,
                                                            workoutSet: set,
                                                          ),
                                                    ),
                                                  );
                                                },
                                                onDelete: () {
                                                  // Using the specific set identifier for deletion
                                                  ref
                                                      .read(
                                                        workoutSetProvider(
                                                          exerciseId,
                                                        ).notifier,
                                                      )
                                                      .deleteSet(
                                                        set,
                                                        set.backendId,
                                                      );
                                                },
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CupertinoActivityIndicator()),
                      error: (err, stack) =>
                          Center(child: Text('Error loading exercises: $err')),
                    );
                  },
                  loading: () =>
                      const Center(child: CupertinoActivityIndicator()),
                  error: (err, stack) =>
                      Center(child: Text('Error loading sets: $err')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
