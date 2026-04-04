import 'package:flutter/foundation.dart';

class AppEndpoints {
  static bool liveWhileDebug = false;

  static String get baseUrl {
    //return baseUrlTest;
    if (kDebugMode && (!liveWhileDebug)) {
      return baseUrlTest;
    } else {
      return baseUrlLive;
    }
  }

  static String baseUrlTest = 'http://localhost:3000';
  static String baseUrlLive = 'https://qarr-tracker.onrender.com';
}
