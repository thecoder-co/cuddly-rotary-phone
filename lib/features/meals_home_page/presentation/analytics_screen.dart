import 'package:calorie_tracker/features/meals/models/meal_analytics_dto.dart';
import 'package:calorie_tracker/features/meals_home_page/presentation/widgets/analytics_app_bar.dart';
import 'package:calorie_tracker/features/meals_home_page/presentation/widgets/analytics_body.dart';
import 'package:calorie_tracker/features/meals_home_page/providers/analytics_provider.dart';
import 'package:calorie_tracker/core/services/local_data/local_data.dart';
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
      backgroundColor: isDark
          ? CupertinoColors.black
          : CupertinoColors.systemGroupedBackground,
      child: Material(
        color: Colors.transparent,
        child: CustomScrollView(
          slivers: [
            AnalyticsAppBar(
              period: _period,
              onPeriodChanged: (p) => setState(() => _period = p),
            ),
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                ref.invalidate(analyticsProvider(_period));
              },
            ),
            analytics.when(
              data: (data) => AnalyticsBody(data: data),
              loading: () => const SliverFillRemaining(
                child: Center(child: CupertinoActivityIndicator()),
              ),
              error: (e, _) => SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        CupertinoIcons.wifi_slash,
                        size: 48,
                        color: Color(0xFF91BF91),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Could not load analytics',
                        style: CustomTextStyle.textmedium16.withColor(
                          isDark ? Colors.white : AppColors.primary700,
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
    );
  }
}

// ---------------------------------------------------------------------------
// Widgets
// ---------------------------------------------------------------------------
