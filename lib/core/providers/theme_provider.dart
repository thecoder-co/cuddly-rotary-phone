import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/packages/packages.dart';

final themeModeProvider =
    NotifierProvider.autoDispose<ThemeModeNotifier, ThemeMode>(
      ThemeModeNotifier.new,
    );

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  build() {
    return LocalData.prefs.getBool('darkMode') == true
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  void toggle() {
    final isDark = state == ThemeMode.dark;
    state = isDark ? ThemeMode.light : ThemeMode.dark;
    LocalData.prefs.setBool('darkMode', !isDark);
  }
}
