import 'package:calorie_tracker/core/providers/theme_provider.dart';
import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/features/home/presentation/home.dart';
import 'package:calorie_tracker/features/auth/presentation/login_screen.dart';
import 'package:calorie_tracker/features/meals/repo/meal_repo.dart';
import 'package:calorie_tracker/features/meals/repo/local_meal_repo.dart';
import 'package:calorie_tracker/features/meals/services/meal_sync_service.dart';
import 'package:calorie_tracker/packages/packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalData.init();
  if (LocalData.token != null) {
    MealSyncService(
      localRepo: LocalMealRepo(),
      cloudRepo: MealCloudRepo(),
    ).syncPendingMeals();
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return GestureDetector(
      onTap: () {
        //close the keypad whenever the user taps on an inactive widget
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: CupertinoTheme(
        data: CupertinoThemeData(
          primaryColor: AppColors.primary,
          brightness: themeMode == ThemeMode.dark
              ? Brightness.dark
              : Brightness.light,
          textTheme: const CupertinoTextThemeData(
            primaryColor: AppColors.primary,
          ),
        ),
        child: MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: ThemeData(
            useMaterial3: false,
            dividerTheme: DividerThemeData(
              thickness: .5,
              space: 1,
              color: Colors.grey.shade200,
            ),
            primarySwatch:
                MaterialColor(AppColors.primary.value, const <int, Color>{
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
                }),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              titleTextStyle: CustomTextStyle.labelXLBold,
              actionsIconTheme: IconThemeData(color: AppColors.primary),
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: AppColors.primary, size: 18),
              backgroundColor: Colors.white,
            ),
            progressIndicatorTheme: const ProgressIndicatorThemeData(
              linearMinHeight: 8,
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                textStyle: WidgetStateProperty.all(CustomTextStyle.labelSmall),
              ),
            ),

            navigationRailTheme: NavigationRailThemeData(
              backgroundColor: AppColors.primary,
              useIndicator: false,
              indicatorColor: AppColors.primary200,
              selectedIconTheme: const IconThemeData(color: Colors.white),
              unselectedIconTheme: const IconThemeData(
                color: AppColors.primary100,
              ),
              labelType: NavigationRailLabelType.none,
              indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.red, width: 4),
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
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: CustomTextStyle.textxSmall12.withColor(
                Colors.black.withOpacity(0.5),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black, width: 1),
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
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black, width: 1),
              ),
              errorStyle: CustomTextStyle.textxSmall12.withColor(
                AppColors.error400,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.5),
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 1),
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
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: false,
            primarySwatch:
                MaterialColor(AppColors.primary.value, const <int, Color>{
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
                }),
            primaryColor: AppColors.primary,
            // Standard Material dark background
            dividerTheme: DividerThemeData(
              thickness: .5,
              space: 1,
              color: Colors.grey.shade800,
            ),
            scaffoldBackgroundColor: const Color(0xFF121212),
            cardColor: const Color(0xFF1E1E1E),
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              secondary: AppColors.primary300,
              surface: Color(0xFF1E1E1E),
              background: Color(0xFF121212),
              onBackground: Colors.white,
              onSurface: Colors.white,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1E1E1E),
              foregroundColor: Colors.white,
              titleTextStyle: CustomTextStyle.labelXLBold,
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white, size: 18),
              actionsIconTheme: IconThemeData(color: AppColors.primary300),
            ),

            progressIndicatorTheme: const ProgressIndicatorThemeData(
              linearMinHeight: 8,
              color: AppColors.primary300,
            ),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: CustomTextStyle.textxSmall12.withColor(
                Colors.white.withOpacity(0.35),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 16,
              ),
              // Neutral, standard dark-mode borders (not green-tinted)
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.15),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.15),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.primary300,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.07),
                  width: 1,
                ),
              ),
              errorStyle: CustomTextStyle.textxSmall12.withColor(
                AppColors.error400,
              ),
            ),
            textTheme: TextTheme(
              bodyLarge: CustomTextStyle.textlarge18.withColor(Colors.white),
              bodyMedium: CustomTextStyle.textmedium16.withColor(Colors.white),
              bodySmall: CustomTextStyle.textsmall14.withColor(
                Colors.white.withOpacity(0.85),
              ),
              displayLarge: CustomTextStyle.textextraBold24.withColor(
                Colors.white,
              ),
              displayMedium: CustomTextStyle.textxLarge20.withColor(
                Colors.white,
              ),
              titleMedium: CustomTextStyle.textlarge18.w500.withColor(
                Colors.white,
              ),
            ),
          ),
          home: const TokenRouter(),
        ),
      ),
    );
  }
}

class TokenRouter extends StatelessWidget {
  const TokenRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}
