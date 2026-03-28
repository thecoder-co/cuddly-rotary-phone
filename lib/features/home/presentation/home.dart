import 'package:calorie_tracker/features/home/providers/index_provider.dart';
import 'package:calorie_tracker/features/home_page/presentation/home_page.dart';
import 'package:calorie_tracker/features/meals/presentation/meals.dart';
import 'package:calorie_tracker/packages/nav_bar/custom_nav_bar.dart';
import 'package:calorie_tracker/packages/packages.dart';
import 'dart:async';

import 'package:upgrader/upgrader.dart';

class HasViewed {
  static List<String> codes = [];
}

class Home extends ConsumerStatefulWidget {
  final int startIndex;
  const Home({super.key, this.startIndex = 0});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(indexProvider.notifier).state = widget.startIndex;
      initUniLinks();
      // NotifHandler.refreshTokens();
    });
  }

  Future<void> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      // final uri = await getInitialUri();

      // if (uri == null) return;
      // final urlString = uri.toString();
      // if (HasViewed.codes.contains(urlString)) return;

      // HasViewed.codes.add(urlString);
      // if (urlString.contains('group-cart?scCode')) {
      //   final cartCode = uri.queryParameters['scCode']?.replaceAll('-', '');
      //   if (cartCode == null) return;
      //   pushTo(GroupSharingScreen(cartCode: cartCode));
      // } else if (urlString.contains('profile?gsCode')) {
      //   'https://app.test.studynest.africa/products/12/profile?gsCode=kml-uhf-bip&saleType=GROUP_ITEM';
      //   final cartCode = uri.queryParameters['gsCode']?.replaceAll('-', '');
      //   if (cartCode == null) return;
      //   pushTo(JoinGroupDealProductScreen(cartCode: cartCode));
      // } else if (urlString.contains('/products/tags/special')) {
      //   final tagId = uri.queryParameters['defaultTagId'];
      //   if (tagId == null) return;
      //   moveToTagPage(ProductCategoryTagType.special, tagId);
      // } else if (urlString.contains('/products/tags/category')) {
      //   final tagId = uri.queryParameters['defaultTagId'];
      //   if (tagId == null) return;
      //   moveToTagPage(ProductCategoryTagType.category, tagId);
      // } else if (urlString.contains('/deposit')) {
      //   'https://app.studynest.africa/deposit?amount=5000';
      //   final amount = uri.queryParameters['amount'];
      //   pushTo(TopupScreen(amount: num.tryParse(amount ?? '')));
      // }
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  bool canPop = false;

  bool checkPop(BuildContext context) {
    if (canPop) {
      return true;
    } else {
      canPop = true;
      ref.read(indexProvider.notifier).state = 0;
      Dialogs.showSnackbar(message: 'Click again to exit');
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
    return WillPopScope(
      onWillPop: () async {
        return checkPop(context);
      },
      child: UpgradeAlert(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body: [
            const HomePage(),
            const MealsPage(),
            Container(),
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
