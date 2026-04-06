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
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Analytics',
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.primary900,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.06),
            width: 0.5,
          ),
        ),
      ),
      backgroundColor: isDark
          ? CupertinoColors.black
          : CupertinoColors.systemGroupedBackground,
      child: Material(
        color: Colors.transparent,
        child: CustomScrollView(
          slivers: [
            // Safe area to keep the segment control below the app bar natively without clipping the scroll
            SliverSafeArea(
              bottom: false,
              sliver: AnalyticsPeriodSelector(
                period: _period,
                onPeriodChanged: (p) => setState(() => _period = p),
              ),
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
