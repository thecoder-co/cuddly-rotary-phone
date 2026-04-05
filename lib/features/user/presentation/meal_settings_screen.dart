import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/packages/packages.dart';
import 'package:flutter/cupertino.dart';

class MealSettingsScreen extends StatefulWidget {
  const MealSettingsScreen({super.key});

  @override
  State<MealSettingsScreen> createState() => _MealSettingsScreenState();
}

class _MealSettingsScreenState extends State<MealSettingsScreen> {
  late bool _useCustom;
  late int _defaultBudget;
  late Map<int, int> _dayBudgets;

  static const _dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    _useCustom = LocalData.useCustomCalorieBudget;
    _defaultBudget = LocalData.calorieBudget;
    _dayBudgets = {
      for (int i = 1; i <= 7; i++) i: LocalData.getCalorieBudgetForDay(i),
    };
  }

  Future<void> _saveDefaultBudget(int value) async {
    setState(() => _defaultBudget = value);
    await LocalData.setCalorieBudget(value);
  }

  Future<void> _saveDayBudget(int day, int value) async {
    setState(() => _dayBudgets[day] = value);
    await LocalData.setCalorieBudgetForDay(day, value);
  }

  Future<void> _toggleCustom(bool value) async {
    setState(() => _useCustom = value);
    await LocalData.setUseCustomCalorieBudget(value);
  }

  void _showBudgetPicker({
    required int currentValue,
    required ValueChanged<int> onChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Range: 500 to 10000 in steps of 50
    const min = 500;
    const step = 50;
    const count = 191; // (10000 - 500) / 50 + 1
    final initialIndex = ((currentValue - min) / step).clamp(0, count - 1).round();

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Material(
        color: Colors.transparent,
        child: Container(
          height: 250,
          color: isDark
              ? const Color(0xFF1C1C1E)
              : CupertinoColors.systemBackground,
          child: Column(
            children: [
              // Toolbar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CupertinoButton(
                      child: const Text('Done'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: initialIndex,
                  ),
                  itemExtent: 36,
                  onSelectedItemChanged: (idx) {
                    onChanged(min + idx * step);
                  },
                  children: List.generate(
                    count,
                    (i) => Center(
                      child: Text(
                        '${min + i * step} kcal',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 18,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoPageScaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : CupertinoColors.systemGroupedBackground,
      child: Material(
        color: Colors.transparent,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Meal Settings'),
              previousPageTitle: 'Settings',
              backgroundColor: isDark
                  ? const Color(0xFF121212)
                  : CupertinoColors.systemGroupedBackground,
              border: null,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Calorie Budget Section
                    _buildSectionLabel('CALORIE BUDGET'),
                    if (!_useCustom) ...[
                      _buildTile(
                        icon: CupertinoIcons.flame,
                        iconColor: Colors.orange,
                        title: 'Daily Budget',
                        subtitle: '$_defaultBudget kcal',
                        onTap: () => _showBudgetPicker(
                          currentValue: _defaultBudget,
                          onChanged: _saveDefaultBudget,
                        ),
                      ),
                    ],
                    _buildTile(
                      icon: CupertinoIcons.calendar,
                      iconColor: AppColors.primary,
                      title: 'Custom Per Day',
                      trailing: CupertinoSwitch(
                        value: _useCustom,
                        activeTrackColor: AppColors.primary,
                        onChanged: _toggleCustom,
                      ),
                    ),
                    if (_useCustom) ...[
                      const SizedBox(height: 12),
                      _buildSectionLabel('PER-DAY BUDGETS'),
                      for (int i = 1; i <= 7; i++)
                        _buildTile(
                          icon: CupertinoIcons.circle_fill,
                          iconColor: _dayColor(i),
                          title: _dayNames[i - 1],
                          subtitle: '${_dayBudgets[i]} kcal',
                          onTap: () => _showBudgetPicker(
                            currentValue: _dayBudgets[i]!,
                            onChanged: (v) => _saveDayBudget(i, v),
                          ),
                        ),
                    ],
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _dayColor(int day) {
    const colors = [
      Colors.blue,
      Colors.teal,
      Colors.green,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.red,
    ];
    return colors[(day - 1) % colors.length];
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        label,
        style: CustomTextStyle.textsmall14
            .withColor(AppColors.greyTertiary)
            .copyWith(fontSize: 11, letterSpacing: 1.1),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: CustomTextStyle.textsmall14.w600.withColor(
                  isDark ? Colors.white : AppColors.primary900,
                ),
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle,
                style: CustomTextStyle.textsmall14.withColor(
                  AppColors.greyTertiary,
                ),
              ),
            if (trailing != null) trailing,
            if (trailing == null && onTap != null) ...[
              const SizedBox(width: 8),
              const Icon(
                CupertinoIcons.chevron_right,
                color: AppColors.greySecondary,
                size: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
