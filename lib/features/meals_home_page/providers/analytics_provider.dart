import 'package:calorie_tracker/features/meals/models/meal_analytics_dto.dart';
import 'package:calorie_tracker/features/meals/repo/meal_repo.dart';
import 'package:calorie_tracker/packages/packages.dart';

enum AnalyticsPeriod { week, month, threeMonths }

final analyticsProvider =
    FutureProvider.family<MealAnalyticsDto?, AnalyticsPeriod>((
      ref,
      period,
    ) async {
      final now = DateTime.now();
      final dateGte = switch (period) {
        AnalyticsPeriod.week => now.subtract(const Duration(days: 7)),
        AnalyticsPeriod.month => now.subtract(const Duration(days: 30)),
        AnalyticsPeriod.threeMonths => now.subtract(const Duration(days: 90)),
      };
      String fmt(DateTime d) =>
          '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

      final res = await MealCloudRepo().getAnalytics(dateGte: fmt(dateGte));
      if (res.valid && res.data != null) return res.data;
      return null;
    });
