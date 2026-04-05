import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:calorie_tracker/features/workout/models/workout_set.dart';
import 'package:calorie_tracker/features/workout/providers/workout_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class EditSetScreen extends ConsumerStatefulWidget {
  final Exercise exercise;
  final WorkoutSet workoutSet;

  const EditSetScreen({
    super.key,
    required this.exercise,
    required this.workoutSet,
  });

  @override
  ConsumerState<EditSetScreen> createState() => _EditSetScreenState();
}

class _EditSetScreenState extends ConsumerState<EditSetScreen> {
  late int reps;
  late double weight;
  late TextEditingController _commentController;
  late DateTime date;

  @override
  void initState() {
    super.initState();
    reps = widget.workoutSet.reps ?? 0;
    weight = widget.workoutSet.weight ?? 0.0;
    _commentController = TextEditingController(text: widget.workoutSet.comment);
    date = widget.workoutSet.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _save() {
    final updatedSet = widget.workoutSet.copyWith(
      reps: reps,
      weight: weight,
      comment: _commentController.text,
      date: date,
    );

    ref
        .read(
          workoutSetProvider(
            widget.exercise.backendId ?? widget.exercise.id.toString(),
          ).notifier,
        )
        .updateSet(updatedSet, updatedSet.backendId);

    Navigator.pop(context);
  }

  void _delete() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Delete Set'),
        content: const Text('Are you sure you want to delete this set?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              ref
                  .read(
                    workoutSetProvider(
                      widget.exercise.backendId ??
                          widget.exercise.id.toString(),
                    ).notifier,
                  )
                  .deleteSet(widget.workoutSet, widget.workoutSet.backendId);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close screen
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? Colors.black
        : CupertinoColors.systemGroupedBackground;
    final cardColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;

    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: backgroundColor.withOpacity(0.8),
        middle: const Text('Edit Set'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _save,
          child: const Text(
            'Save',
            style: TextStyle(
              color: CupertinoColors.systemGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Exercise Name (Read-only)
              _buildSectionCard(cardColor, [
                _buildEditRow(
                  label: 'Exercise',
                  value: widget.exercise.name ?? 'Exercise',
                  isReadOnly: true,
                ),
              ]),
              const SizedBox(height: 16),

              // Reps and Weight
              _buildSectionCard(cardColor, [
                _buildIncrementRow(
                  label: 'Repetitions',
                  value: reps.toString(),
                  onDecrement: () =>
                      setState(() => reps = (reps - 1).clamp(0, 999)),
                  onIncrement: () =>
                      setState(() => reps = (reps + 1).clamp(0, 999)),
                  onTap: () => _showPicker(
                    'Repetitions',
                    reps,
                    300,
                    (v) => setState(() => reps = v),
                  ),
                ),
                const Divider(height: 1, indent: 16),
                _buildIncrementRow(
                  label: 'Weight (kg)',
                  value: weight.toStringAsFixed(0),
                  onDecrement: () =>
                      setState(() => weight = (weight - 1).clamp(0, 999)),
                  onIncrement: () =>
                      setState(() => weight = (weight + 1).clamp(0, 999)),
                  onTap: () => _showPicker(
                    'Weight',
                    weight.toInt(),
                    500,
                    (v) => setState(() => weight = v.toDouble()),
                  ),
                ),
              ]),
              const SizedBox(height: 24),

              // Notes
              const Text(
                '  NOTES',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              const SizedBox(height: 8),
              _buildSectionCard(cardColor, [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: CupertinoTextField(
                    controller: _commentController,
                    placeholder: 'Comment',
                    maxLines: 3,
                    decoration: null,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 24),

              // Date and Time
              _buildSectionCard(cardColor, [
                _buildPickerRow(
                  label: 'Date',
                  value: DateFormat('dd-MMM-yyyy').format(date),
                  onTap: _showDatePicker,
                ),
                const Divider(height: 1, indent: 16),
                _buildPickerRow(
                  label: 'Time',
                  value: DateFormat('hh:mm a').format(date),
                  onTap: _showTimePicker,
                ),
              ]),
              const SizedBox(height: 8),
              Text(
                '   Exact Time: ${DateFormat('h:mm:ss a').format(date).toLowerCase()}',
                style: const TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              const SizedBox(height: 32),

              // Delete Button
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _delete,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Delete',
                        style: TextStyle(
                          color: CupertinoColors.systemRed,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        CupertinoIcons.delete_solid,
                        color: CupertinoColors.systemRed,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(Color color, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildEditRow({
    required String label,
    required String value,
    bool isReadOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: isReadOnly ? CupertinoColors.systemGrey : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncrementRow({
    required String label,
    required String value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: CupertinoColors.systemGrey,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerRow({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade800
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: date,
          onDateTimeChanged: (newDate) {
            setState(() {
              date = DateTime(
                newDate.year,
                newDate.month,
                newDate.day,
                date.hour,
                date.minute,
                date.second,
              );
            });
          },
        ),
      ),
    );
  }

  void _showTimePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.time,
          initialDateTime: date,
          onDateTimeChanged: (newTime) {
            setState(() {
              date = DateTime(
                date.year,
                date.month,
                date.day,
                newTime.hour,
                newTime.minute,
                newTime.second,
              );
            });
          },
        ),
      ),
    );
  }

  void _showPicker(
    String title,
    int initial,
    int max,
    Function(int) onSelected,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
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
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CupertinoButton(
                    child: const Text('Done'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 32,
                  onSelectedItemChanged: onSelected,
                  scrollController: FixedExtentScrollController(
                    initialItem: initial,
                  ),
                  children: List.generate(
                    max,
                    (index) => Center(child: Text(index.toString())),
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
