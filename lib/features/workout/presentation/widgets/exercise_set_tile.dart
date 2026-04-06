import 'package:calorie_tracker/features/workout/models/workout_set.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ExerciseSetTile extends StatelessWidget {
  final WorkoutSet workoutSet;
  final VoidCallback onRepeat;
  final VoidCallback onDelete;

  const ExerciseSetTile({
    super.key,
    required this.workoutSet,
    required this.onRepeat,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Default to a placeholder if date is null, but models usually have dates.
    final timeStr = workoutSet.date != null
        ? DateFormat('h:mm a').format(workoutSet.date!)
        : DateFormat('h:mm a').format(DateTime.now());

    return Slidable(
      key: ValueKey(workoutSet.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onRepeat(),
            backgroundColor: CupertinoColors.activeGreen,
            foregroundColor: Colors.white,
            icon: CupertinoIcons.repeat,
            label: 'Repeat',
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
      child: InkWell(
        onTap: onRepeat,
        child: Container(
          color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              SizedBox(
                width: 70,
                child: Text(
                  timeStr.toLowerCase(),
                  style: TextStyle(
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${workoutSet.reps} ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: CupertinoColors.systemGreen.resolveFrom(context),
                      ),
                    ),
                    TextSpan(
                      text: 'rep',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${workoutSet.weight?.toStringAsFixed(0)} ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFFE5A13B), // Gold/Orange
                      ),
                    ),
                    TextSpan(
                      text: 'kg',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
