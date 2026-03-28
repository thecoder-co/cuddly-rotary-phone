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
    return Container(
      height: 59 + MediaQuery.of(context).padding.bottom,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        border: Border(
          top: BorderSide(
            color: AppColors.greySecondary,
            width: 0.5,
          ),
        ),
      ),
      alignment: Alignment.topCenter,
      // padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .mapIndexed(
              (i, e) => Expanded(
                child: InkWell(
                  onTap: () {
                    onTap(i);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        key: ValueKey(i),
                        duration: const Duration(milliseconds: 100),
                        width: i == currentIndex ? 44 : 0,
                        height: 3,
                        decoration: ShapeDecoration(
                          color: AppColors.primary50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      5.gap,
                      SvgPicture.asset(
                        e.icon,
                        color: AppColors.primary50,
                        height: 24,
                      ),
                      4.spacingH,
                      Text(
                        e.title,
                        style: CustomTextStyle.textxSmall12
                            .withColor(AppColors.primary50)
                            .withWeight(switch (i == currentIndex) {
                              true => FontWeight.w500,
                              false => FontWeight.w400,
                            }),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
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
