import 'package:calorie_tracker/features/workout/models/workout_set.dart';
import 'package:calorie_tracker/features/workout/models/workout_analytics_dto.dart';
import 'package:calorie_tracker/features/workout/providers/workout_set_provider.dart';
import 'package:calorie_tracker/features/workout/repo/workout_repo.dart';
import 'package:calorie_tracker/features/workout/providers/workout_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SessionStats {
  final int sets;
  final int repetitions;
  final double volume;
  final double kgPerRep;

  SessionStats({
    required this.sets,
    required this.repetitions,
    required this.volume,
    required this.kgPerRep,
  });

  factory SessionStats.fromSets(List<WorkoutSet> sets) {
    final totalReps = sets.fold<int>(0, (sum, set) => sum + (set.reps ?? 0));
    final totalVolume = sets.fold<double>(
      0,
      (sum, set) => sum + ((set.reps ?? 0) * (set.weight ?? 0)),
    );
    return SessionStats(
      sets: sets.length,
      repetitions: totalReps,
      volume: totalVolume,
      kgPerRep: totalReps > 0 ? totalVolume / totalReps : 0,
    );
  }
}

class ComparisonStats {
  final double delta;
  final double percentage;
  final bool isPositive;

  ComparisonStats({
    required this.delta,
    required this.percentage,
    required this.isPositive,
  });

  factory ComparisonStats.compare(double current, double previous) {
    final delta = current - previous;
    final percentage = previous > 0 ? (delta.abs() / previous) * 100 : 0.0;
    return ComparisonStats(
      delta: delta,
      percentage: percentage,
      isPositive: delta >= 0,
    );
  }
}

class ExerciseAnalytics {
  final SessionStats current;
  final SessionStats? previous;

  ExerciseAnalytics({required this.current, this.previous});

  ComparisonStats get setsDelta => ComparisonStats.compare(
    current.sets.toDouble(),
    previous?.sets.toDouble() ?? 0,
  );
  ComparisonStats get repsDelta => ComparisonStats.compare(
    current.repetitions.toDouble(),
    previous?.repetitions.toDouble() ?? 0,
  );
  ComparisonStats get volumeDelta =>
      ComparisonStats.compare(current.volume, previous?.volume ?? 0);
  ComparisonStats get kgPerRepDelta =>
      ComparisonStats.compare(current.kgPerRep, previous?.kgPerRep ?? 0);
}

final exerciseAnalyticsProvider = Provider.family<ExerciseAnalytics?, String>((
  ref,
  exerciseId,
) {
  final setsAsync = ref.watch(workoutSetProvider(exerciseId));

  return setsAsync.when(
    data: (sets) {
      if (sets.isEmpty) return null;

      // Group by date
      final grouped = <String, List<WorkoutSet>>{};
      for (var set in sets) {
        if (set.date == null) continue;
        final dateKey = DateFormat('yyyy-MM-dd').format(set.date!);
        grouped.putIfAbsent(dateKey, () => []).add(set);
      }

      if (grouped.isEmpty) return null;

      // Sort dates descending
      final sortedDates = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

      final currentSessionSets = grouped[sortedDates[0]]!;
      final previousSessionSets = sortedDates.length > 1
          ? grouped[sortedDates[1]]
          : null;

      return ExerciseAnalytics(
        current: SessionStats.fromSets(currentSessionSets),
        previous: previousSessionSets != null
            ? SessionStats.fromSets(previousSessionSets)
            : null,
      );
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

enum WorkoutAnalyticsPeriod { twoDays, week, month, allTime }

typedef WorkoutAnalyticsQuery = ({
  String exerciseId,
  WorkoutAnalyticsPeriod period,
});

final workoutAnalyticsFutureProvider =
    FutureProvider.family<WorkoutAnalyticsDataDto?, WorkoutAnalyticsQuery>((
      ref,
      arg,
    ) async {
      final now = DateTime.now();
      DateTime? dateGte;

      switch (arg.period) {
        case WorkoutAnalyticsPeriod.twoDays:
          dateGte = now.subtract(const Duration(days: 2));
          break;
        case WorkoutAnalyticsPeriod.week:
          dateGte = now.subtract(const Duration(days: 7));
          break;
        case WorkoutAnalyticsPeriod.month:
          dateGte = now.subtract(const Duration(days: 30));
          break;
        case WorkoutAnalyticsPeriod.allTime:
          dateGte = null;
          break;
      }

      String? formattedDate;
      if (dateGte != null) {
        formattedDate =
            '${dateGte.year}-${dateGte.month.toString().padLeft(2, '0')}-${dateGte.day.toString().padLeft(2, '0')}';
      }

      final repo = WorkoutCloudRepo();
      final res = await repo.getAnalytics(
        exerciseId: arg.exerciseId,
        dateGte: formattedDate,
      );

      if (res.valid && res.data != null) {
        return res.data;
      }
      return null;
    });
