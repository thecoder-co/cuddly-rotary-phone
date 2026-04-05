import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:calorie_tracker/features/workout/models/workout_set.dart';
import 'package:calorie_tracker/features/workout/presentation/edit_set_screen.dart';
import 'package:calorie_tracker/features/workout/presentation/exercise_analytics_screen.dart';
import 'package:calorie_tracker/features/workout/presentation/widgets/exercise_set_tile.dart';
import 'package:calorie_tracker/features/workout/providers/workout_analytics_provider.dart';
import 'package:calorie_tracker/features/workout/providers/workout_provider.dart';
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

  void _showAddSetModal(BuildContext context, [WorkoutSet? duplicateFrom]) {
    double selectedWeight = duplicateFrom?.weight ?? 20.0;
    int selectedReps = duplicateFrom?.reps ?? 10;

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          height: 350,
          color: isDark
              ? const Color(0xFF1C1C1E)
              : CupertinoColors.systemBackground,
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Record Set',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    CupertinoButton(
                      child: const Text('Save'),
                      onPressed: () {
                        // Create and save
                        final newSet = WorkoutSet()
                          ..exerciseId =
                              widget.exercise.backendId ??
                              widget.exercise.id.toString()
                          ..weight = selectedWeight
                          ..reps = selectedReps
                          ..date = DateTime.now();

                        ref
                            .read(
                              workoutSetProvider(
                                widget.exercise.backendId ?? '',
                              ).notifier,
                            )
                            .addSet(newSet);

                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      // Weight Picker
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                            initialItem: selectedWeight.toInt(),
                          ),
                          itemExtent: 32,
                          onSelectedItemChanged: (idx) =>
                              selectedWeight = idx.toDouble(),
                          children: List.generate(
                            300,
                            (index) => Center(child: Text('$index kg')),
                          ),
                        ),
                      ),
                      // Reps Picker
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                            initialItem: selectedReps,
                          ),
                          itemExtent: 32,
                          onSelectedItemChanged: (idx) => selectedReps = idx,
                          children: List.generate(
                            100,
                            (index) => Center(child: Text('$index reps')),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                            _buildHeaderRow(
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
                            _buildHeaderRow(
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
                              child: _buildComparisonCard(context, backendId),
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
                  onPressed: () => _showAddSetModal(context),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGreen,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
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

  Widget _buildHeaderRow({
    required BuildContext context,
    required IconData icon,
    Color? iconColor,
    required String title,
    String? value,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? CupertinoColors.systemGreen,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
            if (value != null)
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            const SizedBox(width: 4),
            const Icon(
              CupertinoIcons.chevron_right,
              size: 16,
              color: CupertinoColors.systemGrey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonCard(BuildContext context, String exerciseId) {
    final analytics = ref.watch(exerciseAnalyticsProvider(exerciseId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (analytics == null) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.shuffle,
                size: 18,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
              const SizedBox(width: 12),
              Text(
                'COMPARED TO PREVIOUS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  label: 'Sets',
                  value: analytics.current.sets.toString(),
                  delta: analytics.setsDelta,
                  barColor: Colors.redAccent,
                ),
              ),
              Expanded(
                child: _StatItem(
                  label: 'Repetitions',
                  value: analytics.current.repetitions.toString(),
                  delta: analytics.repsDelta,
                  barColor: Colors.greenAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  label: 'Volume (kg)',
                  value: analytics.current.volume.toStringAsFixed(0),
                  delta: analytics.volumeDelta,
                  barColor: Colors.blueAccent,
                ),
              ),
              Expanded(
                child: _StatItem(
                  label: 'kg/rep',
                  value: analytics.current.kgPerRep.toStringAsFixed(0),
                  delta: analytics.kgPerRepDelta,
                  barColor: Colors.orangeAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final ComparisonStats delta;
  final Color barColor;

  const _StatItem({
    required this.label,
    required this.value,
    required this.delta,
    required this.barColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 51,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(
                  delta.isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 14,
                  color: delta.isPositive ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 2),
                Text(
                  '${delta.delta.abs().toStringAsFixed(0)} (${delta.percentage.toStringAsFixed(1)}%)',
                  style: TextStyle(
                    color: delta.isPositive ? Colors.green : Colors.red,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
