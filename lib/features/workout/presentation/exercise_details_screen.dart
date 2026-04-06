import 'package:calorie_tracker/core/utils/extensions/widget_extensions.dart';
import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:calorie_tracker/features/workout/models/workout_set.dart';
import 'package:calorie_tracker/features/workout/presentation/edit_set_screen.dart';
import 'package:calorie_tracker/features/workout/presentation/exercise_analytics_screen.dart';
import 'package:calorie_tracker/features/workout/presentation/widgets/exercise_detail_comparison_card.dart';
import 'package:calorie_tracker/features/workout/presentation/widgets/exercise_detail_stat_item.dart';
import 'package:calorie_tracker/features/workout/presentation/widgets/exercise_details_header_row.dart';
import 'package:calorie_tracker/features/workout/presentation/widgets/exercise_set_tile.dart';
import 'package:calorie_tracker/features/workout/presentation/widgets/record_set_sheet.dart';
import 'package:calorie_tracker/features/workout/providers/workout_analytics_provider.dart';
import 'package:calorie_tracker/features/workout/providers/workout_provider.dart';
import 'package:calorie_tracker/features/workout/providers/workout_set_provider.dart';
import 'package:calorie_tracker/packages/buttons/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ExerciseDetailsScreen extends ConsumerStatefulWidget {
  final Exercise exercise;
  const ExerciseDetailsScreen({super.key, required this.exercise});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends ConsumerState<ExerciseDetailsScreen> {
  Map<String, List<WorkoutSet>> _groupSetsByDate(List<WorkoutSet> sets) {
    sets.sort((a, b) {
      final aDate = a.date ?? DateTime.now();
      final bDate = b.date ?? DateTime.now();
      return bDate.compareTo(aDate); // Descending
    });

    final groups = <String, List<WorkoutSet>>{};
    for (var set in sets) {
      final date = set.date ?? DateTime.now();
      final dateStr = DateFormat('EEE, d MMM yyyy').format(date).toUpperCase();
      groups.putIfAbsent(dateStr, () => []).add(set);
    }
    return groups;
  }

  void _showAddSetModal(BuildContext context, [WorkoutSet? prefillFrom]) {
    final initialWeight = prefillFrom?.weight ?? 20.0;
    final initialReps = prefillFrom?.reps ?? 10;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return RecordSetSheet(
          initialWeight: initialWeight,
          initialReps: initialReps,
          onSave: (weight, reps) {
            final newSet = WorkoutSet()
              ..exerciseId =
                  widget.exercise.backendId ?? widget.exercise.id.toString()
              ..weight = weight
              ..reps = reps
              ..date = DateTime.now();

            ref
                .read(
                  workoutSetProvider(widget.exercise.backendId ?? '').notifier,
                )
                .addSet(newSet);

            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Only load if backendId exists, otherwise just show empty using fake ID
    final backendId =
        widget.exercise.backendId ?? 'local_${widget.exercise.id}';
    final setsAsync = ref.watch(workoutSetProvider(backendId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoPageScaffold(
      backgroundColor: isDark
          ? CupertinoColors.black
          : CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: '',
        middle: Text(
          widget.exercise.name ?? 'Exercise',
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.ellipsis_vertical,
            color: isDark ? CupertinoColors.systemGreen : Colors.black,
            size: 22,
          ),
          onPressed: () {},
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  // Top Header Card
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1C1C1E)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            ExerciseDetailsHeaderRow(
                              context: context,
                              icon: CupertinoIcons.graph_circle,
                              title: 'Analytics',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        ExerciseAnalyticsScreen(
                                          exercise: widget.exercise,
                                        ),
                                  ),
                                );
                              },
                            ),
                            const Divider(height: 1, indent: 48),
                            ExerciseDetailsHeaderRow(
                              context: context,
                              icon: Icons.wb_sunny_outlined,
                              iconColor: Colors.purpleAccent,
                              title: '1RM',
                              value: widget.exercise.oneRmFormula ?? 'Epley',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Content
                  setsAsync.when(
                    data: (sets) {
                      if (sets.isEmpty) {
                        return const SliverFillRemaining(
                          child: Center(
                            child: Text(
                              'No sets recorded yet',
                              style: TextStyle(
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                          ),
                        );
                      }

                      final grouped = _groupSetsByDate(sets);
                      final sliverList = <Widget>[];

                      int groupIndex = 0;
                      grouped.forEach((dateString, daySets) {
                        sliverList.add(
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 24,
                              bottom: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dateString,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.grey.shade400
                                        : Colors.grey.shade600,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );

                        // Summary Card (Compared to Previous) - Only for the most recent session
                        if (groupIndex == 0) {
                          sliverList.add(
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: ExerciseDetailComparisonCard(
                                ref: ref,
                                context: context,
                                exerciseId: backendId,
                              ),
                            ),
                          );
                        }

                        sliverList.add(
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
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
                                children: daySets.asMap().entries.map((entry) {
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
                                                    exercise: widget.exercise,
                                                    workoutSet: set,
                                                  ),
                                            ),
                                          );
                                        },
                                        onDelete: () {
                                          ref
                                              .read(
                                                workoutSetProvider(
                                                  backendId,
                                                ).notifier,
                                              )
                                              .deleteSet(set, set.backendId);
                                        },
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                        groupIndex++;
                      });

                      return SliverList(
                        delegate: SliverChildListDelegate(sliverList),
                      );
                    },
                    loading: () => const SliverFillRemaining(
                      child: Center(child: CupertinoActivityIndicator()),
                    ),
                    error: (err, stack) => SliverFillRemaining(
                      child: Center(child: Text('Error: $err')),
                    ),
                  ),

                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 100),
                  ), // Space for FAB
                ],
              ),

              // Floating Action Button
              Positioned(
                bottom: 24,
                right: 24,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // Prefill with the last recorded set
                    final sets = setsAsync.whenData((s) => s).value;
                    WorkoutSet? lastSet;
                    if (sets != null && sets.isNotEmpty) {
                      final sorted = [...sets]
                        ..sort((a, b) {
                          final aDate = a.date ?? DateTime(2000);
                          final bDate = b.date ?? DateTime(2000);
                          return bDate.compareTo(aDate);
                        });
                      lastSet = sorted.first;
                    }
                    _showAddSetModal(context, lastSet);
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGreen,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: isDark ? 0.3 : 0.1,
                          ),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      CupertinoIcons.add,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
