import 'dart:math' as math;
import 'package:calorie_tracker/features/meals/models/meal_analytics_dto.dart';
import 'package:calorie_tracker/packages/packages.dart';
import 'package:fl_chart/fl_chart.dart';

class TrendChart extends StatelessWidget {
  final List<Trend> trends;
  const TrendChart({super.key, required this.trends});

  @override
  Widget build(BuildContext context) {
    if (trends.isEmpty) return const SizedBox();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final values = trends.map((t) => t.calories ?? 0).toList();
    final maxVal = values.isNotEmpty ? values.reduce(math.max) : 0;

    return Container(
      height: 240,
      padding: const EdgeInsets.only(top: 16, right: 24, left: 16, bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.show_chart_rounded,
                color: AppColors.primary,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'Calories over time',
                style: CustomTextStyle.textsmall14.withColor(
                  AppColors.primary700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: (maxVal / 3).clamp(1.0, double.infinity),
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: AppColors.primary50,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: (trends.length > 5)
                          ? (trends.length / 5).floorToDouble().clamp(
                              1.0,
                              double.infinity,
                            )
                          : 1.0,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= trends.length)
                          return const SizedBox.shrink();
                        final date = trends[index].date;
                        if (date == null) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${date.month}/${date.day}',
                            style: CustomTextStyle.textsmall14
                                .withColor(AppColors.greyTertiary)
                                .copyWith(fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: CustomTextStyle.textsmall14
                              .withColor(AppColors.greyTertiary)
                              .copyWith(fontSize: 10),
                          textAlign: TextAlign.right,
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: trends.asMap().entries.map((e) {
                      return FlSpot(
                        e.key.toDouble(),
                        (e.value.calories ?? 0).toDouble(),
                      );
                    }).toList(),
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        if (index == 0 || index == trends.length - 1) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 3,
                            strokeColor: AppColors.primary,
                          );
                        }
                        return FlDotCirclePainter(
                          radius: 0,
                          color: Colors.transparent,
                          strokeWidth: 0,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary.withOpacity(0.25),
                          AppColors.primary.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) =>
                        isDark ? const Color(0xFF2C2C2E) : Colors.white,
                    tooltipRoundedRadius: 8,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y.toInt()} kcal',
                          CustomTextStyle.textsmall14.w700.withColor(
                            AppColors.primary,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
