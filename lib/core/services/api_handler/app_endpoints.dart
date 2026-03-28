import 'package:flutter/foundation.dart';

class AppEndpoints {
  static bool liveWhileDebug = true;

  static String get baseUrl {
    //return baseUrlTest;
    if (kDebugMode && (!liveWhileDebug)) {
      return baseUrlTest;
    } else {
      return baseUrlLive;
    }
  }

  static String baseUrlTest = 'https://api.test.calorie_tracker.africa';
  static String baseUrlLive = 'https://api.calorie_tracker.africa';

  static String get baseUrlWeb {
    //return baseUrlWebTest;
    if (kDebugMode && (!liveWhileDebug)) {
      return baseUrlWebTest;
    } else {
      return baseUrlWebLive;
    }
  }

  static String baseUrlWebTest = 'https://app.test.calorie_tracker.africa';
  static String baseUrlWebLive = 'https://app.calorie_tracker.africa';
}
