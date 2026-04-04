import 'package:calorie_tracker/features/meals/models/meal_analytics_dto.dart';
import 'package:calorie_tracker/features/meals_home_page/providers/analytics_provider.dart';
import 'package:calorie_tracker/packages/packages.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

class MealAnalyticsScreen extends ConsumerStatefulWidget {
  const MealAnalyticsScreen({super.key});

  @override
  ConsumerState<MealAnalyticsScreen> createState() =>
      _MealAnalyticsScreenState();
}

class _MealAnalyticsScreenState extends ConsumerState<MealAnalyticsScreen> {
  AnalyticsPeriod _period = AnalyticsPeriod.month;

  @override
  Widget build(BuildContext context) {
    final analytics = ref.watch(analyticsProvider(_period));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return CupertinoPageScaffold(
      child: Material(
        color: Colors.transparent,
        child: CustomScrollView(
          slivers: [
            _AnalyticsAppBar(
              period: _period,
              onPeriodChanged: (p) => setState(() => _period = p),
            ),
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                ref.invalidate(analyticsProvider(_period));
              },
            ),
            analytics.when(
              data: (data) => _AnalyticsBody(data: data),
              loading: () => const SliverFillRemaining(
                child: Center(child: CupertinoActivityIndicator()),
              ),
              error: (e, _) => SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(CupertinoIcons.wifi_slash,
                          size: 48, color: Color(0xFF91BF91)),
                      const SizedBox(height: 12),
                      Text('Could not load analytics',
                          style: CustomTextStyle.textmedium16.withColor(
                              isDark ? Colors.white : AppColors.primary700)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// App Bar
// ---------------------------------------------------------------------------

class _AnalyticsAppBar extends StatelessWidget {
  final AnalyticsPeriod period;
  final ValueChanged<AnalyticsPeriod> onPeriodChanged;

  const _AnalyticsAppBar({required this.period, required this.onPeriodChanged});

  static const _labels = {
    AnalyticsPeriod.week: '7 Days',
    AnalyticsPeriod.month: '30 Days',
    AnalyticsPeriod.threeMonths: '3 Months',
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF121212) : Colors.white;

    return SliverAppBar(
      pinned: true,
      backgroundColor: surfaceColor,
      elevation: 0,
      expandedHeight: 0,
      toolbarHeight: 56,
      automaticallyImplyLeading: false,
      title: Text(
        'Analytics',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: isDark ? Colors.white : AppColors.primary900,
          letterSpacing: -0.3,
        ),
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CupertinoSlidingSegmentedControl<AnalyticsPeriod>(
            groupValue: period,
            onValueChanged: (v) {
              if (v != null) onPeriodChanged(v);
            },
            backgroundColor:
                isDark ? const Color(0xFF2C2C2E) : CupertinoColors.systemFill,
            thumbColor: AppColors.primary,
            children: {
              for (final p in AnalyticsPeriod.values)
                p: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Text(
                    _labels[p]!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: period == p
                          ? Colors.white
                          : (isDark
                              ? Colors.white.withOpacity(0.65)
                              : AppColors.primary700),
                    ),
                  ),
                ),
            },
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          thickness: 0.5,
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.06),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Body
// ---------------------------------------------------------------------------

class _AnalyticsBody extends StatelessWidget {
  final MealAnalyticsDto? data;

  const _AnalyticsBody({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const SliverFillRemaining(
        child: Center(child: Text('No data for this period')),
      );
    }
    final summary = data!.summary;
    final topMeals = data!.topMeals ?? [];
    final trend = data!.trend ?? [];

    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          // --- Summary Cards ---
          const _SectionTitle('Overview'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.local_fire_department_rounded,
                  label: 'Avg. Calories',
                  value: '${summary?.averageDailyCalories ?? 0}',
                  unit: 'kcal/day',
                  color: const Color(0xFFE45858),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.fitness_center_rounded,
                  label: 'Avg. Protein',
                  value: '${summary?.averageDailyProtein ?? 0}',
                  unit: 'g/day',
                  color: const Color(0xFF42A5F5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.restaurant_rounded,
                  label: 'Meals Logged',
                  value: '${summary?.totalMealsLogged ?? 0}',
                  unit: 'total',
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.calendar_today_rounded,
                  label: 'Days Tracked',
                  value: '${summary?.totalDaysTracked ?? 0}',
                  unit: 'days',
                  color: const Color(0xFF7E57C2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // --- Calorie Trend Chart ---
          if (trend.isNotEmpty) ...[
            const _SectionTitle('Calorie Trend'),
            const SizedBox(height: 12),
            _TrendChart(trends: trend),
            const SizedBox(height: 28),
          ],

          // --- Top Meals ---
          if (topMeals.isNotEmpty) ...[
            const _SectionTitle('Most Eaten Meals'),
            const SizedBox(height: 12),
            ...topMeals.asMap().entries.map((e) {
              final rank = e.key + 1;
              final meal = e.value;
              final maxCount =
                  topMeals.map((m) => m.count ?? 0).reduce(math.max);
              final fraction =
                  maxCount > 0 ? (meal.count ?? 0) / maxCount : 0.0;
              return _TopMealRow(rank: rank, meal: meal, fraction: fraction);
            }),
          ],

          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Widgets
// ---------------------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(title,
        style: CustomTextStyle.textmedium16.w700
            .withColor(isDark ? Colors.white : AppColors.primary900));
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 12),
          Text(value,
              style: CustomTextStyle.textxLarge20.w700.withColor(color)),
          const SizedBox(height: 2),
          Text(unit,
              style: CustomTextStyle.textsmall14
                  .withColor(AppColors.greyTertiary)),
          const SizedBox(height: 4),
          Text(label,
              style: CustomTextStyle.textsmall14
                  .withColor(AppColors.greySecondary)
                  .copyWith(fontSize: 11)),
        ],
      ),
    );
  }
}

class _TopMealRow extends StatelessWidget {
  final int rank;
  final TopMeal meal;
  final double fraction;

  const _TopMealRow(
      {required this.rank, required this.meal, required this.fraction});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final rankColor = switch (rank) {
      1 => const Color(0xFFFFD700),
      2 => const Color(0xFFB0BEC5),
      3 => const Color(0xFFCD7F32),
      _ => AppColors.greySecondary,
    };
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank badge
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: rankColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('$rank',
                  style: CustomTextStyle.textsmall14.w700.withColor(rankColor)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(meal.name ?? '—',
                    style: CustomTextStyle.textsmall14.w600.withColor(
                        isDark ? Colors.white : AppColors.primary900)),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: fraction,
                    minHeight: 5,
                    backgroundColor: AppColors.primary50,
                    valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text('×${meal.count}',
              style: CustomTextStyle.textsmall14.w700
                  .withColor(AppColors.primary600)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Custom Trend Chart Painter
// ---------------------------------------------------------------------------

class _TrendChart extends StatelessWidget {
  final List<Trend> trends;
  const _TrendChart({required this.trends});

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
              const Icon(Icons.show_chart_rounded, color: AppColors.primary, size: 16),
              const SizedBox(width: 6),
              Text('Calories over time', style: CustomTextStyle.textsmall14.withColor(AppColors.primary700)),
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
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: (trends.length > 5) ? (trends.length / 5).floorToDouble().clamp(1.0, double.infinity) : 1.0,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= trends.length) return const SizedBox.shrink();
                        final date = trends[index].date;
                        if (date == null) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${date.month}/${date.day}',
                            style: CustomTextStyle.textsmall14.withColor(AppColors.greyTertiary).copyWith(fontSize: 10),
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
                          style: CustomTextStyle.textsmall14.withColor(AppColors.greyTertiary).copyWith(fontSize: 10),
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
                      return FlSpot(e.key.toDouble(), (e.value.calories ?? 0).toDouble());
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
                        return FlDotCirclePainter(radius: 0, color: Colors.transparent, strokeWidth: 0);
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
                    getTooltipColor: (_) => isDark ? const Color(0xFF2C2C2E) : Colors.white,
                    tooltipRoundedRadius: 8,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y.toInt()} kcal',
                          CustomTextStyle.textsmall14.w700.withColor(AppColors.primary),
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
