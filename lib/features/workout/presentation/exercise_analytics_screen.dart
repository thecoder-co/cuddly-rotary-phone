import 'package:calorie_tracker/features/workout/models/exercise.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

class ExerciseAnalyticsScreen extends ConsumerStatefulWidget {
  final Exercise exercise;

  const ExerciseAnalyticsScreen({super.key, required this.exercise});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExerciseAnalyticsScreenState();
}

class _ExerciseAnalyticsScreenState extends ConsumerState<ExerciseAnalyticsScreen> {
  int _selectedTabIndex = 1; // 0: 2 Days, 1: Week, 2: Month, 3: All Time
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = CupertinoColors.systemGreen;

    return CupertinoPageScaffold(
      backgroundColor: isDark ? CupertinoColors.black : CupertinoColors.systemGroupedBackground,
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
            
            // Stats Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildStatCard('Total Volume', '14,500 kg', isDark),
                  const SizedBox(width: 16),
                  _buildStatCard('Max Weight', '315 kg', isDark),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildStatCard('Total Reps', '450', isDark),
                  const SizedBox(width: 16),
                  _buildStatCard('Total Sets', '45', isDark),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Chart Placeholder
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Volume Trend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 16),
                      Expanded(
                        child: LineChart(
                          LineChartData(
                            gridData: const FlGridData(show: false),
                            titlesData: const FlTitlesData(
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: _getMockData(),
                                isCurved: true,
                                color: primaryColor,
                                barWidth: 3,
                                isStrokeCapRound: true,
                                dotData: const FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: primaryColor.withOpacity(0.2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
  
  List<FlSpot> _getMockData() {
    switch (_selectedTabIndex) {
      case 0: return [const FlSpot(0, 1), const FlSpot(1, 1.5)];
      case 1: return [const FlSpot(0, 1), const FlSpot(1, 1.5), const FlSpot(2, 1.4), const FlSpot(3, 3.4), const FlSpot(4, 2), const FlSpot(5, 2.2), const FlSpot(6, 1.8)];
      case 2: return List.generate(30, (i) => FlSpot(i.toDouble(), 1 + (i % 5).toDouble() * 0.5));
      case 3: return List.generate(12, (i) => FlSpot(i.toDouble(), 1 + i.toDouble() * 0.2));
      default: return [];
    }
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
            Text(title, style: const TextStyle(color: CupertinoColors.systemGrey, fontSize: 13)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
