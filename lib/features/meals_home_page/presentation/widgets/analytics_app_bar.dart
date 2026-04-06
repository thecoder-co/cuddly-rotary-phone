import 'package:calorie_tracker/features/meals_home_page/providers/analytics_provider.dart';
import 'package:calorie_tracker/packages/packages.dart';

class AnalyticsAppBar extends StatelessWidget {
  final AnalyticsPeriod period;
  final ValueChanged<AnalyticsPeriod> onPeriodChanged;

  const AnalyticsAppBar({
    super.key,
    required this.period,
    required this.onPeriodChanged,
  });

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
      // automaticallyImplyLeading: false,
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
            backgroundColor: isDark
                ? const Color(0xFF2C2C2E)
                : CupertinoColors.systemFill,
            thumbColor: AppColors.primary,
            children: {
              for (final p in AnalyticsPeriod.values)
                p: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
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
