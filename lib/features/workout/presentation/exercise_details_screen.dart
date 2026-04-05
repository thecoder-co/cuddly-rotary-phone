import 'package:calorie_tracker/core/utils/extensions/widget_extensions.dart';
import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:calorie_tracker/features/workout/models/workout_set.dart';
import 'package:calorie_tracker/features/workout/presentation/edit_set_screen.dart';
import 'package:calorie_tracker/features/workout/presentation/exercise_analytics_screen.dart';
import 'package:calorie_tracker/features/workout/presentation/widgets/exercise_set_tile.dart';
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
        return _RecordSetSheet(
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

class _RecordSetSheet extends StatefulWidget {
  final double initialWeight;
  final int initialReps;
  final void Function(double weight, int reps) onSave;

  const _RecordSetSheet({
    required this.initialWeight,
    required this.initialReps,
    required this.onSave,
  });

  @override
  State<_RecordSetSheet> createState() => _RecordSetSheetState();
}

class _RecordSetSheetState extends State<_RecordSetSheet> {
  late double _weight;
  late int _reps;
  int _activeRow = 1; // 0 = reps, 1 = weight
  String _inputBuffer = '';
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _weight = widget.initialWeight;
    _reps = widget.initialReps;
  }

  void _onNumpadKey(String key) {
    setState(() {
      if (key == '⌫') {
        // Backspace
        if (_inputBuffer.isNotEmpty) {
          _inputBuffer = _inputBuffer.substring(0, _inputBuffer.length - 1);
        }
        if (_inputBuffer.isEmpty) {
          _isTyping = false;
          if (_activeRow == 0) {
            _reps = 0;
          } else {
            _weight = 0;
          }
          return;
        }
      } else if (key == '.') {
        // Decimal point — only for weight
        if (_activeRow != 1) return;
        if (!_isTyping) {
          _inputBuffer = '0.';
          _isTyping = true;
        } else if (!_inputBuffer.contains('.')) {
          _inputBuffer += '.';
        }
      } else {
        // Digit
        if (!_isTyping) {
          _inputBuffer = key;
          _isTyping = true;
        } else {
          _inputBuffer += key;
        }
      }

      // Apply buffer to active value
      if (_activeRow == 0) {
        _reps = int.tryParse(_inputBuffer) ?? 0;
      } else {
        _weight = double.tryParse(_inputBuffer) ?? 0.0;
      }
    });
  }

  void _switchActiveRow(int row) {
    setState(() {
      _activeRow = row;
      _isTyping = false;
      _inputBuffer = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // WEIGHT label
              Row(
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text(
                    'WEIGHT',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Reps Row
              GestureDetector(
                onTap: () => _switchActiveRow(0),
                child: _buildStepperRow(
                  value: '$_reps',
                  unit: 'rep',
                  isActive: _activeRow == 0,
                  hasLargeStep: false,
                  onSmallDecrement: () => setState(() {
                    _isTyping = false;
                    _inputBuffer = '';
                    if (_reps > 0) _reps--;
                  }),
                  onSmallIncrement: () => setState(() {
                    _isTyping = false;
                    _inputBuffer = '';
                    _reps++;
                  }),
                ),
              ),
              const SizedBox(height: 10),
              // Weight Row
              GestureDetector(
                onTap: () => _switchActiveRow(1),
                child: _buildStepperRow(
                  value: _weight % 1 == 0
                      ? '${_weight.toInt()}'
                      : _weight.toStringAsFixed(1),
                  unit: 'kg',
                  isActive: _activeRow == 1,
                  hasLargeStep: true,
                  onLargeDecrement: () => setState(() {
                    _isTyping = false;
                    _inputBuffer = '';
                    _weight = (_weight - 5).clamp(0.0, 999.0);
                  }),
                  onSmallDecrement: () => setState(() {
                    _isTyping = false;
                    _inputBuffer = '';
                    _weight = (_weight - 1).clamp(0.0, 999.0);
                  }),
                  onSmallIncrement: () => setState(() {
                    _isTyping = false;
                    _inputBuffer = '';
                    _weight = (_weight + 1).clamp(0.0, 999.0);
                  }),
                  onLargeIncrement: () => setState(() {
                    _isTyping = false;
                    _inputBuffer = '';
                    _weight = (_weight + 5).clamp(0.0, 999.0);
                  }),
                ),
              ),
              const SizedBox(height: 20),
              // Record Set Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: AppButton(
                  onPressed: () => widget.onSave(_weight, _reps),
                  label: 'Record Set',
                ),
              ),
              const SizedBox(height: 16),
              // Numpad
              _buildNumpad(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumpad() {
    const keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['.', '0', '⌫'],
    ];

    return Column(
      children: keys.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: row.map((key) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _buildNumpadKey(key),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNumpadKey(String key) {
    final isBackspace = key == '⌫';
    final isDot = key == '.';
    // Disable dot for reps row
    final isDisabled = isDot && _activeRow == 0;

    return GestureDetector(
      onTap: isDisabled ? null : () => _onNumpadKey(key),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isDisabled
              ? const Color(0xFF2C2C2E).withValues(alpha: 0.3)
              : const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isBackspace
              ? Icon(
                  CupertinoIcons.delete_left,
                  color: Colors.white.withValues(alpha: 0.9),
                  size: 22,
                )
              : Text(
                  key,
                  style: TextStyle(
                    color: isDisabled ? Colors.grey.shade700 : Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildStepperRow({
    required String value,
    required String unit,
    required bool isActive,
    required bool hasLargeStep,
    VoidCallback? onLargeDecrement,
    required VoidCallback onSmallDecrement,
    required VoidCallback onSmallIncrement,
    VoidCallback? onLargeIncrement,
  }) {
    final borderColor = isActive ? Colors.orange : const Color(0xFF2C2C2E);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: isActive ? 2 : 1),
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF2C2C2E),
      ),
      child: Row(
        children: [
          3.gap,
          // Left controls
          Icon(
            Icons.remove,
            color: isDark ? Colors.white : Colors.black,
            size: 14,
          ),

          if (hasLargeStep)
            _buildStepButton(label: '5', onTap: onLargeDecrement),
          _buildStepButton(label: '1', onTap: onSmallDecrement),
          // Center value
          Expanded(
            child: Center(
              child: Text(
                '$value $unit',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          // Right controls
          _buildStepButton(label: '1', onTap: onSmallIncrement),
          if (hasLargeStep)
            _buildStepButton(label: '5', onTap: onLargeIncrement),
          3.gap,
          Icon(
            Icons.add,
            color: isDark ? Colors.white : Colors.black,
            size: 14,
          ),
        ],
      ),
    );
  }

  Widget _buildStepButton({required String label, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A3C),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
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
