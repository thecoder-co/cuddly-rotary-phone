import 'dart:io';

import 'package:flutter/foundation.dart';

class AppEndpoints {
  static bool liveWhileDebug = false;

  static String get baseUrl {
    if (kDebugMode && (!liveWhileDebug)) {
      return Platform.isAndroid ? baseUrlTestAndroid : baseUrlTest;
    } else {
      return baseUrlLive;
    }
  }

  static String baseUrlTest = 'http://localhost:3000';
  static String baseUrlTestAndroid = 'http://10.0.2.2:3000';
  static String baseUrlLive = 'https://qarr-tracker.onrender.com';
}
