import 'package:calorie_tracker/features/workout/providers/workout_analytics_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseDetailStatItem extends StatelessWidget {
  final String label;
  final String value;
  final ComparisonStats delta;
  final Color barColor;

  const ExerciseDetailStatItem({
    super.key,
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
