import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:calorie_tracker/features/workout/providers/workout_analytics_provider.dart';
import 'package:calorie_tracker/features/workout/models/workout_analytics_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

class ExerciseAnalyticsScreen extends ConsumerStatefulWidget {
  final Exercise exercise;

  const ExerciseAnalyticsScreen({super.key, required this.exercise});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExerciseAnalyticsScreenState();
}

class _ExerciseAnalyticsScreenState
    extends ConsumerState<ExerciseAnalyticsScreen> {
  int _selectedTabIndex = 1; // 0: 2 Days, 1: Week, 2: Month, 3: All Time

  WorkoutAnalyticsPeriod _getPeriod() {
    switch (_selectedTabIndex) {
      case 0:
        return WorkoutAnalyticsPeriod.twoDays;
      case 1:
        return WorkoutAnalyticsPeriod.week;
      case 2:
        return WorkoutAnalyticsPeriod.month;
      case 3:
      default:
        return WorkoutAnalyticsPeriod.allTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final query = (
      exerciseId: widget.exercise.backendId ?? '',
      period: _getPeriod(),
    );
    final analyticsAsync = ref.watch(workoutAnalyticsFutureProvider(query));

    return CupertinoPageScaffold(
      backgroundColor: isDark
          ? CupertinoColors.black
          : CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Back',
        middle: Text('${widget.exercise.name} Analytics'),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoSlidingSegmentedControl<int>(
                    groupValue: _selectedTabIndex,
                    children: const {
                      0: Text('2 Days'),
                      1: Text('Week'),
                      2: Text('Month'),
                      3: Text('All'),
                    },
                    onValueChanged: (val) {
                      if (val != null) setState(() => _selectedTabIndex = val);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: analyticsAsync.when(
                  data: (data) {
                    if (data == null) {
                      return const Center(
                        child: Text('No analytical data found.'),
                      );
                    }
                    return _buildContent(data, isDark);
                  },
                  loading: () =>
                      const Center(child: CupertinoActivityIndicator()),
                  error: (err, st) => Center(child: Text('Error: $err')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(WorkoutAnalyticsDataDto data, bool isDark) {
    final aggr = data.aggregates;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: [
        // Stats Grid
        Row(
          children: [
            _buildStatCard(
              'Total Volume',
              '${aggr?.totalVolume?.toStringAsFixed(1) ?? '0'} kg',
              isDark,
            ),
            const SizedBox(width: 16),
            _buildStatCard(
              'Max Weight',
              '${aggr?.maxWeight?.toStringAsFixed(1) ?? '0'} kg',
              isDark,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildStatCard('Total Reps', '${aggr?.totalReps ?? 0}', isDark),
            const SizedBox(width: 16),
            _buildStatCard(
              'Total Sessions',
              '${aggr?.totalSessions ?? 0}',
              isDark,
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Weight & Reps Trend Chart
        if (data.timeSeries != null && data.timeSeries!.isNotEmpty) ...[
          _buildDualAxisChart(data.timeSeries!, isDark),
          const SizedBox(height: 32),
        ],

        // 1RM Trend Chart
        if (data.oneRmTrend != null && data.oneRmTrend!.isNotEmpty) ...[
          _buildOneRmChart(data.oneRmTrend!, isDark),
          const SizedBox(height: 32),
        ],
      ],
    );
  }

  Widget _buildStatCard(String title, String value, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDualAxisChart(
    List<WorkoutTimeSeriesDto> timeSeries,
    bool isDark,
  ) {
    // Left axis -> Weight (green)
    // Right axis -> Reps (red)

    double maxWeight = 0;
    double maxReps = 0;
    for (var d in timeSeries) {
      if ((d.maxWeight ?? 0) > maxWeight) maxWeight = d.maxWeight!;
      if ((d.totalReps ?? 0) > maxReps) maxReps = d.totalReps!.toDouble();
    }

    // Scale factor to map Reps into the Weight coordinate system.
    final scaleFactor = maxWeight > 0 && maxReps > 0
        ? (maxWeight / maxReps)
        : 1.0;

    // Sort chronologically
    final sorted = List.of(timeSeries)
      ..sort((a, b) => (a.date ?? '').compareTo(b.date ?? ''));

    final weightSpots = <FlSpot>[];
    final repsSpots = <FlSpot>[];

    for (int i = 0; i < sorted.length; i++) {
      final d = sorted[i];
      weightSpots.add(FlSpot(i.toDouble(), d.maxWeight ?? 0));
      repsSpots.add(FlSpot(i.toDouble(), (d.totalReps ?? 0) * scaleFactor));
    }

    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Weight vs Reps',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                children: [
                  _buildLegendItem(
                    'Max Weight (kg)',
                    CupertinoColors.systemGreen,
                  ),
                  const SizedBox(width: 8),
                  _buildLegendItem('Total Reps', CupertinoColors.systemRed),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (val, meta) => Text(
                        val.toInt().toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: CupertinoColors.systemGreen,
                        ),
                      ),
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (val, meta) {
                        final originalVal = val / scaleFactor;
                        return Text(
                          originalVal.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: CupertinoColors.systemRed,
                          ),
                          textAlign: TextAlign.right,
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        final isReps = spot.barIndex == 1; // 1 is reps red line
                        if (isReps) {
                          final val = spot.y / scaleFactor;
                          return LineTooltipItem(
                            '${val.toInt()} reps',
                            const TextStyle(color: CupertinoColors.systemRed),
                          );
                        } else {
                          return LineTooltipItem(
                            '${spot.y.toStringAsFixed(1)} kg',
                            const TextStyle(color: CupertinoColors.systemGreen),
                          );
                        }
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: [
                  // Weight (Primary Left)
                  LineChartBarData(
                    spots: weightSpots,
                    isCurved: true,
                    color: CupertinoColors.systemGreen,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  ),
                  // Reps (Mapped to match weight)
                  LineChartBarData(
                    spots: repsSpots,
                    isCurved: true,
                    color: CupertinoColors.systemRed,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 10, color: color)),
      ],
    );
  }

  Widget _buildOneRmChart(List<WorkoutOneRmTrendDto> trend, bool isDark) {
    final sorted = List.of(trend)
      ..sort((a, b) => (a.date ?? '').compareTo(b.date ?? ''));
    final spots = <FlSpot>[];
    for (int i = 0; i < sorted.length; i++) {
      spots.add(FlSpot(i.toDouble(), sorted[i].oneRm ?? 0));
    }

    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '1RM Trend (kg)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (val, meta) => Text(
                        val.toInt().toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y.toStringAsFixed(1)} kg',
                          const TextStyle(color: CupertinoColors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: CupertinoColors.activeBlue,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: CupertinoColors.activeBlue.withValues(alpha: 0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
