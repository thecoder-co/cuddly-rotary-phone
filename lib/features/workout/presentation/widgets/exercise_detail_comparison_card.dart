import 'package:calorie_tracker/features/workout/presentation/widgets/exercise_detail_stat_item.dart';
import 'package:calorie_tracker/features/workout/providers/workout_analytics_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseDetailComparisonCard extends StatelessWidget {
  const ExerciseDetailComparisonCard({
    super.key,
    required this.ref,
    required this.context,
    required this.exerciseId,
  });

  final WidgetRef ref;
  final BuildContext context;
  final String exerciseId;

  @override
  Widget build(BuildContext context) {
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
                child: ExerciseDetailStatItem(
                  label: 'Sets',
                  value: analytics.current.sets.toString(),
                  delta: analytics.setsDelta,
                  barColor: Colors.redAccent,
                ),
              ),
              Expanded(
                child: ExerciseDetailStatItem(
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
                child: ExerciseDetailStatItem(
                  label: 'Volume (kg)',
                  value: analytics.current.volume.toStringAsFixed(0),
                  delta: analytics.volumeDelta,
                  barColor: Colors.blueAccent,
                ),
              ),
              Expanded(
                child: ExerciseDetailStatItem(
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
