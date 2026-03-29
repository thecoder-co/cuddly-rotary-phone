import 'package:calorie_tracker/core/dialogs/toast.dart';
import 'package:calorie_tracker/features/meals_home/providers/index_provider.dart';
import 'package:calorie_tracker/features/meals_home_page/presentation/analytics_screen.dart';
import 'package:calorie_tracker/features/meals_home_page/presentation/home_page.dart';
import 'package:calorie_tracker/features/meals/presentation/meals.dart';
import 'package:calorie_tracker/packages/nav_bar/custom_nav_bar.dart';
import 'package:calorie_tracker/packages/packages.dart';
import 'dart:async';

import 'package:upgrader/upgrader.dart';

class HasViewed {
  static List<String> codes = [];
}

class MealsHome extends ConsumerStatefulWidget {
  final int startIndex;
  const MealsHome({super.key, this.startIndex = 0});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<MealsHome> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(indexProvider.notifier).state = widget.startIndex;
      initUniLinks();
    });
  }

  Future<void> initUniLinks() async {
    try {} on PlatformException {}
  }

  bool canPop = false;

  bool checkPop(BuildContext context) {
    if (canPop) {
      return true;
    } else {
      canPop = true;
      ref.read(indexProvider.notifier).state = 0;
      AppToast.info('Click again to exit');
      Future.delayed(const Duration(seconds: 4), () {
        canPop = false;
      });
      return false;
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(indexProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor:
            isDark ? const Color(0xFF121212) : Colors.white,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
      child: UpgradeAlert(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: [
            const HomePage(),
            const MealsPage(),
            const MealAnalyticsScreen(),
          ][index],
          bottomNavigationBar: CustomBottomNav(
            currentIndex: switch (index) {
              4 => 0,
              _ => index,
            },
            onTap: (i) {
              ref.read(indexProvider.notifier).state = i;
            },
            items: [
              CustomNavBarItem(
                icon: IconsaxBold.home2,
                title: 'Home',
              ),
              CustomNavBarItem(
                icon: IconsaxBold.award,
                title: 'Meals',
              ),
              CustomNavBarItem(
                icon: IconsaxBold.menu,
                title: 'Analytics',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
