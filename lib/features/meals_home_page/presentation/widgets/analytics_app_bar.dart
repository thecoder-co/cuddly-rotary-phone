import 'package:calorie_tracker/features/meals_home_page/providers/analytics_provider.dart';
import 'package:calorie_tracker/packages/packages.dart';

class AnalyticsPeriodSelector extends StatelessWidget {
  final AnalyticsPeriod period;
  final ValueChanged<AnalyticsPeriod> onPeriodChanged;

  const AnalyticsPeriodSelector({
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

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: SizedBox(
          width: double.infinity,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 6,
                  ),
                  child: Text(
                    _labels[p]!,
                    style: TextStyle(
                      fontSize: 13,
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
      ),
    );
  }
}
