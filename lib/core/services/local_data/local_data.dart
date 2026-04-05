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
}
