import 'package:calorie_tracker/packages/packages.dart';

class CustomBottomNav extends ConsumerWidget {
  final List<CustomNavBarItem> items;
  final int currentIndex;
  final Function(int) onTap;
  const CustomBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Light: white tab bar with green accent (standard iOS)
    // Dark: #1C1C1E (iOS system background level 2)
    final activeColor = isDark ? AppColors.primary300 : AppColors.primary;
    final inactiveColor = isDark
        ? Colors.white.withOpacity(0.45)
        : CupertinoColors.inactiveGray;

    return CupertinoTabBar(
      currentIndex: currentIndex,
      onTap: onTap,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      backgroundColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
      border: Border(
        top: BorderSide(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.12),
          width: 0.5,
        ),
      ),
      items: items
          .asMap()
          .entries
          .map(
            (entry) => BottomNavigationBarItem(
              icon: SvgPicture.asset(
                entry.value.icon,
                colorFilter: ColorFilter.mode(
                  entry.key == currentIndex ? activeColor : inactiveColor,
                  BlendMode.srcIn,
                ),
                height: 24,
              ),
              label: entry.value.title,
            ),
          )
          .toList(),
    );
  }
}

class CustomNavBarItem {
  final String icon;
  final String title;
  final dynamic badge;

  CustomNavBarItem({
    required this.icon,
    required this.title,
    this.badge,
  });
}
