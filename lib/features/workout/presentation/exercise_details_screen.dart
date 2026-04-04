import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:calorie_tracker/features/workout/models/workout_set.dart';
import 'package:calorie_tracker/features/workout/presentation/exercise_analytics_screen.dart';
import 'package:calorie_tracker/features/workout/presentation/widgets/exercise_set_tile.dart';
import 'package:calorie_tracker/features/workout/providers/workout_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ExerciseDetailsScreen extends ConsumerStatefulWidget {
  final Exercise exercise;
  const ExerciseDetailsScreen({super.key, required this.exercise});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExerciseDetailsScreenState();
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
          color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.systemBackground,
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
                    const Text('Record Set', style: TextStyle(fontWeight: FontWeight.bold)),
                    CupertinoButton(
                      child: const Text('Save'),
                      onPressed: () {
                        // Create and save
                        final newSet = WorkoutSet()
                          ..exerciseId = widget.exercise.backendId ?? widget.exercise.id.toString()
                          ..weight = selectedWeight
                          ..reps = selectedReps
                          ..date = DateTime.now();
                          
                        ref.read(workoutSetProvider(widget.exercise.backendId ?? '').notifier)
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
                          scrollController: FixedExtentScrollController(initialItem: selectedWeight.toInt()),
                          itemExtent: 32,
                          onSelectedItemChanged: (idx) => selectedWeight = idx.toDouble(),
                          children: List.generate(300, (index) => Center(child: Text('$index kg'))),
                        ),
                      ),
                      // Reps Picker
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(initialItem: selectedReps),
                          itemExtent: 32,
                          onSelectedItemChanged: (idx) => selectedReps = idx,
                          children: List.generate(100, (index) => Center(child: Text('$index reps'))),
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
    final backendId = widget.exercise.backendId ?? 'local_${widget.exercise.id}';
    final setsAsync = ref.watch(workoutSetProvider(backendId));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return CupertinoPageScaffold(
      backgroundColor: isDark ? CupertinoColors.black : CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Exercises',
        middle: Text(widget.exercise.name ?? 'Exercise'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.ellipsis_circle_fill, color: CupertinoColors.systemGreen),
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
                // Top Header Buttons
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildHeaderButton(
                          context: context,
                          icon: CupertinoIcons.chart_bar_alt_fill,
                          title: 'Analytics',
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ExerciseAnalyticsScreen(exercise: widget.exercise),
                              ),
                            );
                          },
                        ),
                        _buildHeaderButton(
                          context: context, 
                          icon: CupertinoIcons.settings, 
                          title: '1RM', 
                          value: widget.exercise.oneRmFormula ?? 'Epley',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Content
                setsAsync.when(
                  data: (sets) {
                    if (sets.isEmpty) {
                      return const SliverFillRemaining(
                        child: Center(child: Text('No sets recorded yet', style: TextStyle(color: CupertinoColors.systemGrey))),
                      );
                    }
                    
                    final grouped = _groupSetsByDate(sets);
                    final sliverList = <Widget>[];
                    
                    grouped.forEach((dateString, daySets) {
                      sliverList.add(
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(dateString, style: TextStyle(color: isDark ? Colors.grey.shade400 : Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.bold)),
                              const Icon(CupertinoIcons.chevron_right, size: 14, color: CupertinoColors.systemGrey),
                            ],
                          ),
                        ),
                      );
                      
                      // Example Summary Card for the first element or all (simulated)
                      sliverList.add(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('COMPARED TO PREVIOUS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.systemGrey)),
                                SizedBox(height: 12),
                                // This would be populated by backend actual analytics data
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _StatItem(label: 'Sets', value: '--', isPositive: false),
                                    _StatItem(label: 'Repetitions', value: '--', isPositive: false),
                                    _StatItem(label: 'Volume', value: '--', isPositive: false),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      
                      sliverList.add(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: daySets.asMap().entries.map((entry) {
                                final idx = entry.key;
                                final set = entry.value;
                                return Column(
                                  children: [
                                    if (idx > 0)
                                      Divider(height: 1, color: isDark ? Colors.grey.shade800 : Colors.grey.shade200, indent: 16),
                                    ExerciseSetTile(
                                      workoutSet: set,
                                      onEdit: () => _showAddSetModal(context, set), // Act as Fill
                                      onDelete: () {
                                        ref.read(workoutSetProvider(backendId).notifier).deleteSet(set, set.backendId);
                                      },
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                    });
                    
                    return SliverList(delegate: SliverChildListDelegate(sliverList));
                  },
                  loading: () => const SliverFillRemaining(child: Center(child: CupertinoActivityIndicator())),
                  error: (err, stack) => SliverFillRemaining(child: Center(child: Text('Error: $err'))),
                ),
                
                const SliverPadding(padding: EdgeInsets.only(bottom: 100)), // Space for FAB
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
                  child: const Icon(CupertinoIcons.add, color: Colors.white, size: 28),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildHeaderButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? value,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: CupertinoColors.systemGreen, size: 20),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: value != null ? 12 : 14, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black)),
                  if (value != null)
                    Text(value, style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isPositive;

  const _StatItem({required this.label, required this.value, required this.isPositive});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: CupertinoColors.systemGrey, fontSize: 12)),
      ],
    );
  }
}
