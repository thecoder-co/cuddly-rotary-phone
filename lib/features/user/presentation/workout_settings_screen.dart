import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/packages/packages.dart';
import 'package:flutter/cupertino.dart';

class WorkoutSettingsScreen extends StatefulWidget {
  const WorkoutSettingsScreen({super.key});

  @override
  State<WorkoutSettingsScreen> createState() => _WorkoutSettingsScreenState();
}

class _WorkoutSettingsScreenState extends State<WorkoutSettingsScreen> {
  late int _restIntervalSeconds;

  @override
  void initState() {
    super.initState();
    _restIntervalSeconds = LocalData.restIntervalSeconds;
  }

  String _formatInterval(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    if (minutes == 0) {
      return '${secs}s';
    }
    if (secs == 0) {
      return '${minutes}m';
    }
    return '${minutes}m ${secs}s';
  }

  void _showRestIntervalPicker() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    // Minutes: 0–10, Seconds: 0–55 in 5s steps
    final initialMin = _restIntervalSeconds ~/ 60;
    final initialSec = (_restIntervalSeconds % 60) ~/ 5;

    int selectedMin = initialMin;
    int selectedSec = initialSec;

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Material(
        color: Colors.transparent,
        child: Container(
          height: 300,
          color: isDark
              ? const Color(0xFF1C1C1E)
              : CupertinoColors.systemBackground,
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'Rest Interval',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: textColor,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      CupertinoButton(
                        child: const Text('Done'),
                        onPressed: () {
                          final total = selectedMin * 60 + selectedSec * 5;
                          // Enforce minimum of 5 seconds
                          final clamped = total < 5 ? 5 : total;
                          setState(() => _restIntervalSeconds = clamped);
                          LocalData.setRestIntervalSeconds(clamped);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      // Minutes wheel
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                            initialItem: initialMin,
                          ),
                          itemExtent: 40,
                          onSelectedItemChanged: (idx) => selectedMin = idx,
                          children: List.generate(
                            11, // 0-10 minutes
                            (i) => Center(
                              child: Text(
                                '$i min',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Seconds wheel
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                            initialItem: initialSec,
                          ),
                          itemExtent: 40,
                          onSelectedItemChanged: (idx) => selectedSec = idx,
                          children: List.generate(
                            12, // 0, 5, 10, ..., 55
                            (i) => Center(
                              child: Text(
                                '${i * 5} sec',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 20,
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
              ],
            ),
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
              largeTitle: const Text('Workout Settings'),
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
                    _buildSectionLabel('REST TIMER'),
                    _buildTile(
                      icon: CupertinoIcons.timer,
                      iconColor: CupertinoColors.systemOrange,
                      title: 'Set Rest Interval',
                      subtitle: _formatInterval(_restIntervalSeconds),
                      onTap: _showRestIntervalPicker,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        'The rest interval timer starts after you record a set. '
                        'It helps you track recovery time between sets.',
                        style: CustomTextStyle.textsmall14.withColor(
                          AppColors.greyTertiary,
                        ),
                      ),
                    ),
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
                color: iconColor.withValues(alpha: 0.15),
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
            if (onTap != null) ...[
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
