import 'package:calorie_tracker/features/workout/models/workout_set.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ExerciseSetTile extends StatelessWidget {
  final WorkoutSet workoutSet;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExerciseSetTile({
    super.key,
    required this.workoutSet,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Default to a placeholder if date is null, but models usually have dates.
    final timeStr = workoutSet.date != null 
        ? DateFormat('HH:mm').format(workoutSet.date!) 
        : DateFormat('HH:mm').format(DateTime.now());

    return Slidable(
      key: ValueKey(workoutSet.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: CupertinoColors.systemGreen,
            foregroundColor: Colors.white,
            icon: CupertinoIcons.add_circled_solid, // "Fill/Duplicate" action
            label: 'Fill',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: CupertinoColors.destructiveRed,
            foregroundColor: Colors.white,
            icon: CupertinoIcons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Text(
                timeStr,
                style: TextStyle(
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                '${workoutSet.reps} rep',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Text(
              '${workoutSet.weight} kg',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
