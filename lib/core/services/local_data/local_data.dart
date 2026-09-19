import 'dart:async';
import 'dart:convert';
import '../notifications/notification_coordinator.dart';
import '../session/credential_store.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'isar_service.dart';

class LocalData {
  static const _accessTokenKey = 'qarrtrack.access-token.v1';
  static const _refreshTokenKey = 'qarrtrack.refresh-token.v1';
  static const _legacyAccessTokenKey = 'token';
  static const _legacyRefreshTokenKey = 'refreshToken';
  static const _onboardingVersion = 1;

  static late SharedPreferences prefs;
  static final accountChanges = StreamController<String?>.broadcast();
  static CredentialStore _credentialStore = const PlatformCredentialStore();
  static Future<void>? _initialization;
  static String? _accessToken;
  static String? _refreshToken;
  static bool _usingLegacyCredentials = false;

  static Future<void> init({CredentialStore? credentialStore}) {
    if (_initialization != null) return _initialization!;
    if (credentialStore != null) _credentialStore = credentialStore;
    return _initialization = _initialize();
  }

  static Future<void> _initialize() async {
    prefs = await SharedPreferences.getInstance();
    await IsarService.init();
    await _loadAndMigrateCredentials();
    await IsarService.openAccount(userId, migrateLegacy: true);
    await IsarService.openMedicationAccount(userId, migrateLegacy: true);
    if (userId != null && await IsarService.hasAmbiguousLegacyTrackingData()) {
      await prefs.setBool('accountDataReconciliationNeeded:$userId', true);
    }
  }

  static Future<void> removeToken() async {
    await _saveMedicationPreferences();
    await _credentialStore.delete(_accessTokenKey);
    await _credentialStore.delete(_refreshTokenKey);
    _accessToken = null;
    _refreshToken = null;
    _usingLegacyCredentials = false;
    await prefs.remove(_legacyAccessTokenKey);
    await prefs.remove(_legacyRefreshTokenKey);
    await prefs.remove('userId');
    await prefs.remove('userEmail');
    await prefs.remove('userName');
    await prefs.remove('userType');
    await IsarService.openAccount(null);
    await IsarService.openMedicationAccount(null);
    accountChanges.add(null);
  }

  static Future<void> _saveMedicationPreferences() async {
    final values = <String, dynamic>{};
    for (final key
        in prefs
            .getKeys()
            .where((key) => key.startsWith('medication_'))
            .toList()) {
      if (key.startsWith('medication_scheduled_')) {
        for (final occurrence in prefs.getStringList(key) ?? <String>[]) {
          await NotificationCoordinator.instance.cancelMedication(occurrence);
        }
      } else {
        values[key] = prefs.get(key);
      }
      await prefs.remove(key);
    }
    if (userId != null)
      await prefs.setString(
        'accountMedicationSettings:$userId',
        jsonEncode(values),
      );
    await prefs.remove('pending_notification_action');
  }

  static Future<void> _loadAndMigrateCredentials() async {
    final legacyAccess = prefs.getString(_legacyAccessTokenKey);
    final legacyRefresh = prefs.getString(_legacyRefreshTokenKey);
    try {
      var access = await _credentialStore.read(_accessTokenKey);
      var refresh = await _credentialStore.read(_refreshTokenKey);

      access = await _migrateCredential(
        secureKey: _accessTokenKey,
        legacyKey: _legacyAccessTokenKey,
        legacyValue: legacyAccess,
        secureValue: access,
      );
      refresh = await _migrateCredential(
        secureKey: _refreshTokenKey,
        legacyKey: _legacyRefreshTokenKey,
        legacyValue: legacyRefresh,
        secureValue: refresh,
      );
      _accessToken = access;
      _refreshToken = refresh;
      _usingLegacyCredentials = false;
    } catch (_) {
      // Keep the legacy values intact if secure storage cannot be reached. This
      // lets a later launch retry the verified migration instead of losing a
      // session during a partial platform-storage failure.
      _accessToken = legacyAccess;
      _refreshToken = legacyRefresh;
      _usingLegacyCredentials = legacyAccess != null || legacyRefresh != null;
    }
  }

  static Future<String?> _migrateCredential({
    required String secureKey,
    required String legacyKey,
    required String? legacyValue,
    required String? secureValue,
  }) async {
    if (legacyValue == null || legacyValue.isEmpty) return secureValue;
    if (secureValue == null || secureValue.isEmpty) {
      await _credentialStore.write(secureKey, legacyValue);
      secureValue = await _credentialStore.read(secureKey);
    }
    if (secureValue == legacyValue) {
      await prefs.remove(legacyKey);
    }
    return secureValue;
  }

  static Future<void> _writeCredentials(
    String token, {
    required String refreshToken,
  }) async {
    await _credentialStore.write(_accessTokenKey, token);
    if (await _credentialStore.read(_accessTokenKey) != token) {
      throw StateError('Could not verify secure access-token storage.');
    }
    await _credentialStore.write(_refreshTokenKey, refreshToken);
    if (await _credentialStore.read(_refreshTokenKey) != refreshToken) {
      throw StateError('Could not verify secure refresh-token storage.');
    }
    _accessToken = token;
    _refreshToken = refreshToken;
    _usingLegacyCredentials = false;
    await prefs.remove(_legacyAccessTokenKey);
    await prefs.remove(_legacyRefreshTokenKey);
  }

  static Future<void> setToken(String token, {String? refreshToken}) async {
    final nextRefreshToken = refreshToken ?? _refreshToken;
    if (nextRefreshToken == null || nextRefreshToken.isEmpty) {
      throw StateError('A refresh token is required when storing a session.');
    }
    await _writeCredentials(token, refreshToken: nextRefreshToken);
  }

  static Future<void> setUserInfo(
    String id,
    String? email,
    String name, {
    String? userType,
    bool announce = true,
  }) async {
    if (userId != id) {
      if (userId != null) await _saveMedicationPreferences();
      await IsarService.openAccount(id);
      await IsarService.openMedicationAccount(id);
      await _restoreMedicationPreferences(id);
    }
    await prefs.setString('userId', id);
    if (email == null || email.isEmpty) {
      await prefs.remove('userEmail');
    } else {
      await prefs.setString('userEmail', email);
    }
    await prefs.setString('userName', name);
    if (userType != null) await prefs.setString('userType', userType);
    if (announce) accountChanges.add(id);
  }

  static Future<void> _restoreMedicationPreferences(String id) async {
    final encoded = prefs.getString('accountMedicationSettings:$id');
    if (encoded == null) return;
    final saved = jsonDecode(encoded) as Map;
    for (final entry in saved.entries) {
      final key = entry.key as String;
      final value = entry.value;
      if (value is bool) await prefs.setBool(key, value);
      if (value is int) await prefs.setInt(key, value);
      if (value is double) await prefs.setDouble(key, value);
      if (value is String) await prefs.setString(key, value);
      if (value is List && value.every((item) => item is String)) {
        await prefs.setStringList(key, value.cast<String>());
      }
    }
  }

  /// Saves a complete authenticated session and announces it only once both
  /// credentials and account-local storage are ready.
  static Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String id,
    required String? email,
    required String name,
    required String userType,
  }) async {
    final previousAccessToken = _accessToken;
    final previousRefreshToken = _refreshToken;
    await _writeCredentials(accessToken, refreshToken: refreshToken);
    try {
      await setUserInfo(id, email, name, userType: userType, announce: false);
    } catch (_) {
      if (previousAccessToken != null && previousRefreshToken != null) {
        await _writeCredentials(
          previousAccessToken,
          refreshToken: previousRefreshToken,
        );
      } else {
        await _credentialStore.delete(_accessTokenKey);
        await _credentialStore.delete(_refreshTokenKey);
        _accessToken = null;
        _refreshToken = null;
      }
      rethrow;
    }
    accountChanges.add(id);
  }

  // The preference fallback exists solely during a verified one-time migration
  // (and for recoverable storage failures). It is never written by new session
  // saves and is removed after secure storage has confirmed the values.
  static String? get token =>
      _accessToken ?? _legacyPreference(_legacyAccessTokenKey);
  static String? get refreshToken =>
      _refreshToken ?? _legacyPreference(_legacyRefreshTokenKey);
  static bool get hasCredentials =>
      token != null && token!.isNotEmpty && refreshToken != null;
  static bool get usingLegacyCredentials => _usingLegacyCredentials;

  static String? _legacyPreference(String key) {
    try {
      return prefs.getString(key);
    } catch (_) {
      return null;
    }
  }

  static String? get userId => prefs.getString('userId');
  static String? get userEmail => prefs.getString('userEmail');
  static String? get userName => prefs.getString('userName');
  static String? get userType => prefs.getString('userType');

  static Future<void> setOnboarded(bool isOnboarded) async {
    await prefs.setBool('isOnboarded', isOnboarded);
    if (isOnboarded) {
      await prefs.setInt('onboardingVersion', _onboardingVersion);
    }
  }

  static bool get isOnboarded {
    return prefs.getBool('isOnboarded') == true &&
        prefs.getInt('onboardingVersion') == _onboardingVersion;
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
