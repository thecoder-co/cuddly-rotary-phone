import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';
import '../../../features/medications/models/medication_models.dart';
import '../../../features/medications/repo/local_medication_repo.dart';
import '../../../features/medications/services/medication_recurrence_engine.dart';
import '../local_data/local_data.dart';

class NotificationPayload {
  final int version;
  final String feature;
  final String occurrenceKey;
  final String? accountId;
  final String? action;
  const NotificationPayload({
    this.version = 2,
    required this.feature,
    required this.occurrenceKey,
    this.accountId,
    this.action,
  });
  Map<String, dynamic> toJson() => {
    'version': version,
    'feature': feature,
    'occurrenceKey': occurrenceKey,
    'accountId': accountId,
    'action': action,
  };
  static NotificationPayload? parse(String? value) {
    if (value == null) return null;
    try {
      final json = jsonDecode(value) as Map<String, dynamic>;
      return NotificationPayload(
        version: json['version'] as int? ?? 1,
        feature: json['feature'] as String,
        occurrenceKey: json['occurrenceKey'] as String,
        accountId: json['accountId'] as String?,
        action: json['action'] as String?,
      );
    } catch (_) {
      return null;
    }
  }

  bool belongsTo(String? activeAccountId) =>
      accountId != null && accountId == activeAccountId;
}

@pragma('vm:entry-point')
Future<void> notificationBackgroundResponse(
  NotificationResponse response,
) async {
  final prefs = await SharedPreferences.getInstance();
  final payload = NotificationPayload.parse(response.payload);
  if (payload == null) return;
  final action = response.actionId?.isNotEmpty == true
      ? response.actionId
      : payload.action;
  if (action != null) {
    try {
      await LocalData.init();
      await NotificationCoordinator.instance.initialize();
      if (await _recordMedicationNotificationAction(payload, action)) return;
    } catch (_) {
      // Persist below so the app can safely retry when it next opens.
    }
  }
  await prefs.setString(
    'pending_notification_action',
    jsonEncode({
      ...payload.toJson(),
      'action': action,
      'receivedAt': DateTime.now().toUtc().toIso8601String(),
    }),
  );
}

class NotificationCoordinator {
  NotificationCoordinator._();
  static final instance = NotificationCoordinator._();
  final plugin = FlutterLocalNotificationsPlugin();
  ValueChanged<NotificationPayload>? onPayload;
  NotificationPayload? _launchPayload;

  Future<void> initialize() async {
    tz_data.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (_) {}
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      notificationCategories: <DarwinNotificationCategory>[
        DarwinNotificationCategory(
          'medication_dose',
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain('TAKEN', 'Taken'),
            DarwinNotificationAction.plain('SNOOZED', 'Snooze'),
            DarwinNotificationAction.plain('SKIPPED', 'Skip'),
          ],
        ),
      ],
    );
    await plugin.initialize(
      settings: InitializationSettings(android: android, iOS: darwin),
      onDidReceiveNotificationResponse: _handleResponse,
      onDidReceiveBackgroundNotificationResponse:
          notificationBackgroundResponse,
    );
    final launch = await plugin.getNotificationAppLaunchDetails();
    if (launch?.didNotificationLaunchApp == true)
      _launchPayload = NotificationPayload.parse(
        launch?.notificationResponse?.payload,
      );
    final prefs = await SharedPreferences.getInstance();
    final pending = prefs.getString('pending_notification_action');
    if (pending != null) {
      _launchPayload = NotificationPayload.parse(pending);
      await prefs.remove('pending_notification_action');
    }
  }

  void _handleResponse(NotificationResponse response) async {
    final parsed = NotificationPayload.parse(response.payload);
    if (parsed == null) return;
    final payload = NotificationPayload(
      feature: parsed.feature,
      occurrenceKey: parsed.occurrenceKey,
      accountId: parsed.accountId,
      action: response.actionId?.isNotEmpty == true
          ? response.actionId
          : parsed.action,
    );
    try {
      if (payload.action != null &&
          await _recordMedicationNotificationAction(payload, payload.action!)) {
        return;
      }
    } catch (_) {
      // Keep the action available in the app if background persistence failed.
    }
    if (onPayload != null)
      onPayload!(payload);
    else
      _launchPayload = payload;
  }

  NotificationPayload? takeLaunchPayload() {
    final value = _launchPayload;
    _launchPayload = null;
    return value;
  }

  void deferPayload(NotificationPayload payload) {
    _launchPayload = payload;
  }

  int notificationId(String occurrenceKey, {int offset = 0}) {
    final bytes = sha256.convert(utf8.encode(occurrenceKey)).bytes;
    return ((bytes[0] << 23) | (bytes[1] << 15) | (bytes[2] << 7) | bytes[3]) &
            0x7fffffff ^
        offset;
  }

  Future<void> scheduleMedication({
    required String occurrenceKey,
    required DateTime scheduledAt,
    required String title,
    required String body,
    bool ongoing = false,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final sound = prefs.getBool('medication_sound') ?? true;
    final vibration = prefs.getBool('medication_vibration') ?? true;
    final payload = jsonEncode(
      NotificationPayload(
        feature: 'medications',
        occurrenceKey: occurrenceKey,
        accountId: LocalData.userId,
      ).toJson(),
    );
    final actions = const [
      AndroidNotificationAction('TAKEN', 'Taken', showsUserInterface: false),
      AndroidNotificationAction(
        'SNOOZED',
        'Snooze',
        showsUserInterface: false,
        cancelNotification: false,
      ),
      AndroidNotificationAction('SKIPPED', 'Skip', showsUserInterface: false),
    ];
    final android = AndroidNotificationDetails(
      '${ongoing ? 'medication_follow_up_v1' : 'medication_due_v1'}_s${sound ? 1 : 0}_v${vibration ? 1 : 0}',
      ongoing ? 'Medication follow-ups' : 'Medication reminders',
      channelDescription: ongoing
          ? 'Snoozed medication reminders awaiting an outcome'
          : 'Scheduled medication dose reminders',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: ongoing,
      autoCancel: !ongoing,
      actions: actions,
      category: AndroidNotificationCategory.reminder,
      playSound: sound,
      enableVibration: vibration,
    );
    final ios = DarwinNotificationDetails(
      categoryIdentifier: 'medication_dose',
      interruptionLevel: InterruptionLevel.timeSensitive,
      presentAlert: true,
      presentSound: sound,
    );
    try {
      await plugin.zonedSchedule(
        id: notificationId(occurrenceKey, offset: ongoing ? 1 : 0),
        title: title,
        body: body,
        scheduledDate: tz.TZDateTime.from(scheduledAt, tz.local),
        notificationDetails: NotificationDetails(android: android, iOS: ios),
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (error) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'medication_last_scheduling_error',
        error.toString(),
      );
      await plugin.zonedSchedule(
        id: notificationId(occurrenceKey, offset: ongoing ? 1 : 0),
        title: title,
        body: body,
        scheduledDate: tz.TZDateTime.from(scheduledAt, tz.local),
        notificationDetails: NotificationDetails(android: android, iOS: ios),
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
  }

  Future<void> cancelMedication(String occurrenceKey) async {
    await plugin.cancel(id: notificationId(occurrenceKey));
    await plugin.cancel(id: notificationId(occurrenceKey, offset: 1));
  }

  Future<bool?> requestExactAlarmsPermission() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return null;
    return plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestExactAlarmsPermission();
  }

  Future<Map<String, dynamic>> health() async {
    final pending = await plugin.pendingNotificationRequests();
    bool? exact;
    bool? notifications;
    if (!kIsWeb && Platform.isAndroid) {
      final android = plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      exact = await android?.canScheduleExactNotifications();
      notifications = await android?.areNotificationsEnabled();
    }
    return {
      'notifications': notifications,
      'exactAlarms': exact,
      'scheduledCount': pending.length,
      'nextPayload': pending.firstOrNull?.payload,
      'timezone': tz.local.name,
    };
  }
}

Future<bool> _recordMedicationNotificationAction(
  NotificationPayload payload,
  String action,
) async {
  if (payload.feature != 'medications') return false;
  // Do not apply stale or legacy notifications to the current account. Version
  // one payloads did not carry an account identity and are intentionally not
  // trusted after account-scoped medication storage was introduced.
  if (!payload.belongsTo(LocalData.userId)) return false;
  final outcome = switch (action) {
    'TAKEN' => MedicationDoseOutcome.taken,
    'SNOOZED' => MedicationDoseOutcome.snoozed,
    'SKIPPED' => MedicationDoseOutcome.skipped,
    _ => null,
  };
  if (outcome == null) return false;
  tz_data.initializeTimeZones();
  final local = LocalMedicationRepo();
  final now = DateTime.now();
  MedicationOccurrence? occurrence;
  for (final medication in await local.getActiveMedications()) {
    for (final schedule in await local.schedulesFor(medication.clientId)) {
      final candidates = const MedicationRecurrenceEngine().expand(
        userId: LocalData.userId ?? 'local-user',
        medication: medication,
        schedule: schedule,
        from: now.subtract(const Duration(days: 7)),
        to: now.add(const Duration(days: 7)),
      );
      for (final candidate in candidates) {
        if (candidate.occurrenceKey == payload.occurrenceKey) {
          occurrence = candidate;
          break;
        }
      }
      if (occurrence != null) break;
    }
    if (occurrence != null) break;
  }
  if (occurrence == null) return false;
  final snoozedUntil = outcome == MedicationDoseOutcome.snoozed
      ? now.add(
          Duration(minutes: LocalData.prefs.getInt('medication_snooze') ?? 15),
        )
      : null;
  await local.recordAction(
    occurrence: occurrence,
    clientOperationId: outcome == MedicationDoseOutcome.snoozed
        ? const Uuid().v4()
        : const Uuid().v5(
            Uuid.NAMESPACE_URL,
            'qarrtrack:${payload.occurrenceKey}:$action',
          ),
    outcome: outcome,
    actedAt: now,
    snoozedUntil: snoozedUntil,
  );
  await NotificationCoordinator.instance.cancelMedication(
    payload.occurrenceKey,
  );
  if (snoozedUntil != null) {
    await NotificationCoordinator.instance.scheduleMedication(
      occurrenceKey: payload.occurrenceKey,
      scheduledAt: snoozedUntil,
      title: 'Medication follow-up',
      body: 'This snoozed dose is waiting for an outcome.',
      ongoing: Platform.isAndroid,
    );
  }
  return true;
}

extension _FirstOrNull<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
