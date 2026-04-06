import 'dart:math' as math;
import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/features/meals/models/meal_analytics_dto.dart';
import 'package:calorie_tracker/features/meals_home_page/presentation/analytics_screen.dart';
import 'package:calorie_tracker/features/meals_home_page/presentation/widgets/trend_chart.dart';
import 'package:calorie_tracker/packages/packages.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsBody extends StatelessWidget {
  final MealAnalyticsDto? data;

  const AnalyticsBody({super.key, required this.data});

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
                child: Builder(
                  builder: (context) {
                    final avg = (summary?.averageDailyCalories ?? 0).toInt();
                    final budget = LocalData.averageWeeklyBudget;

                    Color color = const Color(0xFFE45858); // Default reddish
                    if (avg < budget) {
                      color = const Color(0xFF4CAF50); // Green
                    } else if (avg == budget) {
                      color = const Color(0xFFFFA726); // Orange
                    } else {
                      color = const Color(0xFFE53935); // Red
                    }

                    return _StatCard(
                      icon: Icons.local_fire_department_rounded,
                      label: 'Avg. Calories',
                      value: '$avg/$budget',
                      unit: 'kcal/day',
                      color: color,
                    );
                  },
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
            TrendChart(trends: trend),
            const SizedBox(height: 28),
          ],

          // --- Top Meals ---
          if (topMeals.isNotEmpty) ...[
            const _SectionTitle('Most Eaten Meals'),
            const SizedBox(height: 12),
            ...topMeals.asMap().entries.map((e) {
              final rank = e.key + 1;
              final meal = e.value;
              final maxCount = topMeals
                  .map((m) => m.count ?? 0)
                  .reduce(math.max);
              final fraction = maxCount > 0
                  ? (meal.count ?? 0) / maxCount
                  : 0.0;
              return _TopMealRow(rank: rank, meal: meal, fraction: fraction);
            }),
          ],

          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      title,
      style: CustomTextStyle.textmedium16.w700.withColor(
        isDark ? Colors.white : AppColors.primary900,
      ),
    );
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
          Text(
            value,
            style: CustomTextStyle.textxLarge20.w700.withColor(color),
          ),
          const SizedBox(height: 2),
          Text(
            unit,
            style: CustomTextStyle.textsmall14.withColor(
              AppColors.greyTertiary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: CustomTextStyle.textsmall14
                .withColor(AppColors.greySecondary)
                .copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _TopMealRow extends StatelessWidget {
  final int rank;
  final TopMeal meal;
  final double fraction;

  const _TopMealRow({
    required this.rank,
    required this.meal,
    required this.fraction,
  });

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
              child: Text(
                '$rank',
                style: CustomTextStyle.textsmall14.w700.withColor(rankColor),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name ?? '—',
                  style: CustomTextStyle.textsmall14.w600.withColor(
                    isDark ? Colors.white : AppColors.primary900,
                  ),
                ),
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
          Text(
            '×${meal.count}',
            style: CustomTextStyle.textsmall14.w700.withColor(
              AppColors.primary600,
            ),
          ),
        ],
      ),
    );
  }
}
