import 'dart:async';
import 'dart:io';
import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_activities/live_activities.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class TimerState extends Equatable {
  final bool isRunning;
  final DateTime? endTime;
  final Duration remaining;
  final String exerciseName;
  final String? liveActivityId;

  const TimerState({
    this.isRunning = false,
    this.endTime,
    this.remaining = Duration.zero,
    this.exerciseName = '',
    this.liveActivityId,
  });

  TimerState copyWith({
    bool? isRunning,
    DateTime? endTime,
    Duration? remaining,
    String? exerciseName,
    String? liveActivityId,
    bool clearLiveActivityId = false,
  }) {
    return TimerState(
      isRunning: isRunning ?? this.isRunning,
      endTime: endTime ?? this.endTime,
      remaining: remaining ?? this.remaining,
      exerciseName: exerciseName ?? this.exerciseName,
      liveActivityId: clearLiveActivityId
          ? null
          : (liveActivityId ?? this.liveActivityId),
    );
  }

  @override
  List<Object?> get props => [
    isRunning,
    endTime,
    remaining,
    exerciseName,
    liveActivityId,
  ];
}

final workoutTimerProvider = NotifierProvider<WorkoutTimerNotifier, TimerState>(
  WorkoutTimerNotifier.new,
);

class WorkoutTimerNotifier extends Notifier<TimerState> {
  Timer? _timer;
  final _liveActivities = LiveActivities();
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const _runningNotificationId = 8888;
  static const _completionNotificationId = 8889;
  static const _channelId = 'workout_timer_channel';
  static const _channelName = 'Workout Rest Timer';

  @override
  TimerState build() {
    _initNativeServices();

    // Check persistence to see if there's a running timer
    final endTimeMillis = LocalData.prefs.getInt('workout_timer_end_time');
    final name =
        LocalData.prefs.getString('workout_timer_exercise_name') ?? 'Rest';
    final liveActivityId = LocalData.prefs.getString(
      'workout_timer_live_activity_id',
    );

    if (endTimeMillis != null) {
      final endTime = DateTime.fromMillisecondsSinceEpoch(endTimeMillis);
      final remaining = endTime.difference(DateTime.now());
      if (remaining.inSeconds > 0) {
        // Resume timer
        final initialState = TimerState(
          isRunning: true,
          endTime: endTime,
          remaining: remaining,
          exerciseName: name,
          liveActivityId: liveActivityId,
        );
        _startInternalDartTimer(initialState);
        return initialState;
      } else {
        // Clear expired timer data from prefs
        _clearPrefs();
        if (Platform.isIOS && liveActivityId != null) {
           _liveActivities.endActivity(liveActivityId);
        }
      }
    }

    return const TimerState();
  }

  Future<void> _initNativeServices() async {
    tz.initializeTimeZones();
    try {
      final tzInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(tzInfo.identifier));
    } catch (_) {
      // Fallback if unavailable
    }

    // Android Initialization
    if (Platform.isAndroid) {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings initializationSettingsDarwin =
          DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
          );

      const InitializationSettings initializationSettings =
          InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
          );

      await _localNotificationsPlugin.initialize(
        settings: initializationSettings,
      );
    } else if (Platform.isIOS) {
      const DarwinInitializationSettings initializationSettingsDarwin =
          DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
          );
      const InitializationSettings initializationSettings =
          InitializationSettings(
            iOS: initializationSettingsDarwin,
          );
      await _localNotificationsPlugin.initialize(
        settings: initializationSettings,
      );
      _liveActivities.init(
        appGroupId: 'group.com.qarrprojects.trackers',
      ); 
    }
  }

  Future<void> startTimer({String exerciseName = 'Rest'}) async {
    final intervalSeconds = LocalData.restIntervalSeconds;
    final endTime = DateTime.now().add(Duration(seconds: intervalSeconds));

    // Save to SharedPreferences
    await LocalData.prefs.setInt(
      'workout_timer_end_time',
      endTime.millisecondsSinceEpoch,
    );
    await LocalData.prefs.setString(
      'workout_timer_exercise_name',
      exerciseName,
    );

    String? activityId;

    if (Platform.isAndroid) {
      final androidPlugin = _localNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.requestNotificationsPermission();
      await androidPlugin?.requestExactAlarmsPermission();
      _showAndroidOngoingNotification(endTime, exerciseName);
    } else if (Platform.isIOS) {
      activityId = await _startLiveActivity(endTime, exerciseName);
      if (activityId != null) {
        await LocalData.prefs.setString(
          'workout_timer_live_activity_id',
          activityId,
        );
      }
    }
    
    await _scheduleCompletionNotification(endTime, exerciseName);

    state = TimerState(
      isRunning: true,
      endTime: endTime,
      remaining: Duration(seconds: intervalSeconds),
      exerciseName: exerciseName,
      liveActivityId: activityId,
    );

    _startInternalDartTimer(state);
  }

  Future<void> stopTimer({bool isNaturalExpiration = false}) async {
    _timer?.cancel();
    _clearPrefs();

    // Cancel both possible notification IDs to be safe
    await _localNotificationsPlugin.cancel(id: _completionNotificationId);
    await _localNotificationsPlugin.cancel(id: _runningNotificationId);

    if (isNaturalExpiration) {
      await _fireImmediateCompletionNotification(state.exerciseName);
    }

    if (Platform.isIOS) {
      // More robust than ending a specific ID which might be lost/null
      await _liveActivities.endAllActivities();
    }

    state = const TimerState(); // Idle state
  }

  Future<void> _fireImmediateCompletionNotification(String exerciseName) async {
    final androidDetails = const AndroidNotificationDetails(
      'completion_channel',
      'Timer Completion',
      channelDescription: 'Alerts when rest timer finishes',
      importance: Importance.max,
      priority: Priority.high,
      color: Color(0xFF34C759),
      icon: '@mipmap/ic_launcher',
      playSound: true,
    );
    final iosDetails = const DarwinNotificationDetails(
      presentSound: true,
      presentAlert: true,
      interruptionLevel: InterruptionLevel.timeSensitive,
    );
    await _localNotificationsPlugin.show(
      id: _completionNotificationId,
      title: 'Rest Complete!',
      body: 'Time for: $exerciseName',
      notificationDetails: NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
    );
  }

  void addSeconds(int secondsToAdd) {
    if (!state.isRunning || state.endTime == null) return;

    final newEndTime = state.endTime!.add(Duration(seconds: secondsToAdd));

    LocalData.prefs.setInt(
      'workout_timer_end_time',
      newEndTime.millisecondsSinceEpoch,
    );

    _timer?.cancel();
    _localNotificationsPlugin.cancel(id: _completionNotificationId);
    
    _scheduleCompletionNotification(newEndTime, state.exerciseName);

    if (Platform.isAndroid) {
      _showAndroidOngoingNotification(newEndTime, state.exerciseName);
    } else if (Platform.isIOS && state.liveActivityId != null) {
      _updateLiveActivity(
        state.liveActivityId!,
        newEndTime,
        state.exerciseName,
      );
    }

    state = state.copyWith(
      endTime: newEndTime,
      remaining: newEndTime.difference(DateTime.now()),
    );
    _startInternalDartTimer(state);
  }

  void _startInternalDartTimer(TimerState initialState) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.endTime == null) {
        stopTimer();
        return;
      }

      final remaining = state.endTime!.difference(DateTime.now());
      if (remaining.inSeconds <= 0) {
        // If expired natively while Dart is active (within 2 seconds of zero), fire explicitly
        final justExpired = remaining.inSeconds >= -2;
        stopTimer(isNaturalExpiration: justExpired);
      } else {
        state = state.copyWith(remaining: remaining);
      }
    });
  }

  void _clearPrefs() {
    LocalData.prefs.remove('workout_timer_end_time');
    LocalData.prefs.remove('workout_timer_exercise_name');
    LocalData.prefs.remove('workout_timer_live_activity_id');
  }

  Future<void> _showAndroidOngoingNotification(
    DateTime endTime,
    String exerciseName,
  ) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: 'Running timer for workout',
      importance: Importance.low,
      priority: Priority.low,
      showWhen: true,
      when: endTime.millisecondsSinceEpoch,
      usesChronometer: true,
      chronometerCountDown: true,
      ongoing: true, 
      autoCancel: false,
      color: const Color(0xFF34C759),
      icon: '@mipmap/ic_launcher',
    );
    await _localNotificationsPlugin.show(
      id: _runningNotificationId,
      title: 'Rest Timer',
      body: 'Next up: $exerciseName',
      notificationDetails: NotificationDetails(
        android: androidPlatformChannelSpecifics,
      ),
    );
  }
  
  Future<void> _scheduleCompletionNotification(
    DateTime endTime,
    String exerciseName,
  ) async {
    if (Platform.isIOS) {
       final iosPlugin = _localNotificationsPlugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
       await iosPlugin?.requestPermissions(alert: true, badge: true, sound: true);
    }
    
    final androidDetails = const AndroidNotificationDetails(
      'completion_channel',
      'Timer Completion',
      channelDescription: 'Alerts when rest timer finishes',
      importance: Importance.max,
      priority: Priority.high,
      color: Color(0xFF34C759),
      icon: '@mipmap/ic_launcher',
      playSound: true,
    );
    
    final iosDetails = const DarwinNotificationDetails(
      presentSound: true,
      presentAlert: true,
      interruptionLevel: InterruptionLevel.timeSensitive,
    );
    
    await _localNotificationsPlugin.zonedSchedule(
      id: _completionNotificationId,
      title: 'Rest Complete!',
      body: 'Time for: $exerciseName',
      scheduledDate: tz.TZDateTime(
        tz.local,
        endTime.year,
        endTime.month,
        endTime.day,
        endTime.hour,
        endTime.minute,
        endTime.second,
      ),
      notificationDetails: NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<String?> _startLiveActivity(
    DateTime endTime,
    String exerciseName,
  ) async {
    try {
      final activityId = await _liveActivities.createActivity(
        'workout_rest_timer',
        {
          'exerciseName': exerciseName,
          'endTime':
              endTime.millisecondsSinceEpoch ~/
              1000, 
        },
      );
      return activityId;
    } catch (e) {
      return null;
    }
  }

  Future<void> _updateLiveActivity(
    String activityId,
    DateTime newEndTime,
    String exerciseName,
  ) async {
    try {
      await _liveActivities.updateActivity(activityId, {
        'exerciseName': exerciseName,
        'endTime': newEndTime.millisecondsSinceEpoch ~/ 1000,
      });
    } catch (_) {}
  }
}
