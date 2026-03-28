import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/features/home/presentation/home.dart';
import 'package:calorie_tracker/packages/packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await LocalData.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //close the keypad whenever the user taps on an inactive widget
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: MaterialColor(
            AppColors.primary.value,
            const <int, Color>{
              25: AppColors.primary50,
              50: AppColors.primary50,
              100: AppColors.primary100,
              200: AppColors.primary200,
              300: AppColors.primary300,
              400: AppColors.primary,
              500: AppColors.primary,
              600: AppColors.primary600,
              700: AppColors.primary700,
              800: AppColors.primary800,
              900: AppColors.primary900,
            },
          ),
          scaffoldBackgroundColor: const Color(0xFFCAF2CB),
          appBarTheme: const AppBarTheme(
            titleTextStyle: CustomTextStyle.labelXLBold,
            actionsIconTheme: IconThemeData(
              color: AppColors.primary,
            ),
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: AppColors.primary,
              size: 18,
            ),
            backgroundColor: Colors.white,
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            linearMinHeight: 8,
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                CustomTextStyle.labelSmall,
              ),
            ),
          ),
          dividerTheme: const DividerThemeData(
            thickness: 1,
            color: Color(0x7FADADAD),
            space: 1,
          ),
          navigationRailTheme: NavigationRailThemeData(
            backgroundColor: AppColors.primary,
            useIndicator: false,
            indicatorColor: AppColors.primary200,
            selectedIconTheme: const IconThemeData(
              color: Colors.white,
            ),
            unselectedIconTheme: const IconThemeData(
              color: AppColors.primary100,
            ),
            labelType: NavigationRailLabelType.none,
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(
                color: Colors.red,
                width: 4,
              ),
            ),
          ),
          tabBarTheme: TabBarThemeData(
            labelColor: Colors.black,
            labelStyle: CustomTextStyle.textxSmall12.w500,
            unselectedLabelStyle: CustomTextStyle.textxSmall12.w500,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 1,
                color: Colors.black,
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: CustomTextStyle.textxSmall12
                .withColor(Colors.black.withOpacity(0.5)),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 13,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            errorStyle:
                CustomTextStyle.textxSmall12.withColor(AppColors.error400),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.5),
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
          ),
          primaryColor: AppColors.primary,
          textTheme: TextTheme(
            bodyLarge: CustomTextStyle.textlarge18,
            bodyMedium: CustomTextStyle.textmedium16,
            bodySmall: CustomTextStyle.textsmall14,
            displayLarge: CustomTextStyle.textextraBold24,
            displayMedium: CustomTextStyle.textxLarge20,
            displaySmall: CustomTextStyle.textlarge18,
            titleMedium: CustomTextStyle.textlarge18.w500,
          ),
        ),
        home: const TokenRouter(),

        // home: const LoginScreen(),
      ),
    );
  }
}

class TokenRouter extends StatelessWidget {
  const TokenRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Home();
    // return const LoginScreen();
    // if (LocalData.token != null) {
    // } else {
    //   return const Scaffold();
    // }
  }
}
