import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'isar_service.dart';

class LocalData {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    await IsarService.init();
  }

  static Future<void> removeToken() async {
    await prefs.remove('token');
    await prefs.remove('refreshToken');
    await prefs.remove('userId');
    await prefs.remove('userEmail');
    await prefs.remove('userName');
  }

  static Future<void> setToken(String token, {String? refreshToken}) async {
    await prefs.setString('token', token);
    if (refreshToken != null) {
      await prefs.setString('refreshToken', refreshToken);
    }
  }

  static Future<void> setUserInfo(String id, String email, String name) async {
    await prefs.setString('userId', id);
    await prefs.setString('userEmail', email);
    await prefs.setString('userName', name);
  }

  static String? get token => prefs.getString('token');
  static String? get refreshToken => prefs.getString('refreshToken');

  static String? get userId => prefs.getString('userId');
  static String? get userEmail => prefs.getString('userEmail');
  static String? get userName => prefs.getString('userName');

  static Future<void> setOnboarded(bool isOnboarded) async {
    await prefs.setBool('isOnboarded', isOnboarded);
  }

  static bool get isOnboarded {
    return prefs.getBool('isOnboarded') ?? false;
  }

  // store last three searches and also get
  static Future<void> addLastSearch(String search) async {
    final searches = prefs.getStringList('lastSearches') ?? [];
    if (searches.contains(search)) {
      searches.remove(search);
    }
    searches.insert(0, search);
    if (searches.length > 3) {
      searches.removeLast();
    }
    await prefs.setStringList('lastSearches', searches);
  }

  static List<String> get lastSearches {
    return prefs.getStringList('lastSearches') ?? [];
  }

  // ── Module Settings ───────────────────────────────────────────────────────

  // Meal Settings: Calorie Budget
  static int get calorieBudget => prefs.getInt('calorieBudget') ?? 2000;
  static Future<void> setCalorieBudget(int value) async {
    await prefs.setInt('calorieBudget', value);
  }

  static bool get useCustomCalorieBudget =>
      prefs.getBool('useCustomCalorieBudget') ?? false;
  static Future<void> setUseCustomCalorieBudget(bool value) async {
    await prefs.setBool('useCustomCalorieBudget', value);
  }

  // Per-day calorie budgets (Monday=1, Sunday=7)
  static int getCalorieBudgetForDay(int day) {
    return prefs.getInt('calorieBudget_day_$day') ?? calorieBudget;
  }

  /// Returns the budget for the specific date based on current settings
  static int getBudgetForDate(DateTime date) {
    if (!useCustomCalorieBudget) return calorieBudget;
    return getCalorieBudgetForDay(date.weekday);
  }

  /// Average budget for the week (7 days)
  static int get averageWeeklyBudget {
    if (!useCustomCalorieBudget) return calorieBudget;
    int sum = 0;
    for (int i = 1; i <= 7; i++) {
      sum += getCalorieBudgetForDay(i);
    }
    return (sum / 7).round();
  }

  static Future<void> setCalorieBudgetForDay(int day, int value) async {
    await prefs.setInt('calorieBudget_day_$day', value);
  }

  // Workout Settings: Rest Interval (in seconds)
  static int get restIntervalSeconds =>
      prefs.getInt('restIntervalSeconds') ?? 90;
  static Future<void> setRestIntervalSeconds(int value) async {
    await prefs.setInt('restIntervalSeconds', value);
  }
}
