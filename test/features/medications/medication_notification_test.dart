import 'dart:convert';
import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/features/medications/models/medication_models.dart';
import 'package:calorie_tracker/features/medications/repo/local_medication_repo.dart';
import 'package:calorie_tracker/features/medications/services/medication_reminder_scheduler.dart';
import 'package:calorie_tracker/core/services/notifications/notification_coordinator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;

class NotificationScheduleRepo implements LocalMedicationRepo {
  List<MedicationLocal> active = [];
  @override
  Future<List<MedicationLocal>> getActiveMedications() async => active;
  @override
  Future<List<MedicationDoseRecordLocal>> allRecords() async => [];
  @override
  Future<List<MedicationScheduleLocal>> schedulesFor(String id) async => [];
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('dexterous.com/flutter/local_notifications');
  final calls = <MethodCall>[];
  var rejectExact = false;
  final activeIds = <int>[];
  setUp(() async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    tzdata.initializeTimeZones();
    SharedPreferences.setMockInitialValues({});
    LocalData.prefs = await SharedPreferences.getInstance();
    activeIds.clear();
    calls.clear();
    rejectExact = false;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          if (call.method == 'requestExactAlarmsPermission') return true;
          if (call.method == 'getActiveNotifications') {
            return activeIds.map((id) => {'id': id}).toList();
          }
          if (call.method == 'pendingNotificationRequests') return [];
          if (call.method == 'zonedSchedule' &&
              rejectExact &&
              calls.where((c) => c.method == 'zonedSchedule').length == 1) {
            throw PlatformException(code: 'exact_alarms_not_permitted');
          }
          return null;
        });
  });

  test(
    'refresh preserves unanswered delivered alerts and keeps them tracked',
    () async {
      const key = 'delivered-unanswered';
      final repo = NotificationScheduleRepo()
        ..active = [MedicationLocal()..clientId = 'active-med'];
      activeIds.add(NotificationCoordinator.instance.notificationId(key));
      await LocalData.prefs.setStringList('medication_scheduled_active-med', [
        key,
      ]);
      await MedicationReminderScheduler(
        local: repo,
        notifications: NotificationCoordinator.instance,
      ).rescheduleAll();
      expect(calls.where((c) => c.method == 'cancel'), isEmpty);
      expect(LocalData.prefs.getStringList('medication_scheduled_active-med'), [
        key,
      ]);
    },
  );

  test('refresh cancels reminders for remotely archived medications', () async {
    const key = 'archived-dose';
    activeIds.add(NotificationCoordinator.instance.notificationId(key));
    await LocalData.prefs.setStringList('medication_scheduled_archived-med', [
      key,
    ]);
    await MedicationReminderScheduler(
      local: NotificationScheduleRepo(),
      notifications: NotificationCoordinator.instance,
    ).rescheduleAll();
    expect(calls.where((c) => c.method == 'cancel').length, 2);
    expect(
      LocalData.prefs.containsKey('medication_scheduled_archived-med'),
      isFalse,
    );
  });

  test('disabling reminders also clears delivered unanswered alerts', () async {
    const key = 'disabled-dose';
    final repo = NotificationScheduleRepo()
      ..active = [MedicationLocal()..clientId = 'active-med'];
    activeIds.add(NotificationCoordinator.instance.notificationId(key));
    await LocalData.prefs.setBool('medication_reminders', false);
    await LocalData.prefs.setStringList('medication_scheduled_active-med', [
      key,
    ]);
    await MedicationReminderScheduler(
      local: repo,
      notifications: NotificationCoordinator.instance,
    ).rescheduleAll();
    expect(calls.where((c) => c.method == 'cancel').length, 2);
    expect(
      LocalData.prefs.containsKey('medication_scheduled_active-med'),
      isFalse,
    );
  });
  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('exact-alarm setup requests the dedicated Android permission', () async {
    expect(
      await NotificationCoordinator.instance.requestExactAlarmsPermission(),
      isTrue,
    );
    expect(calls.single.method, 'requestExactAlarmsPermission');
  });

  test(
    'dose alerts include three background actions and a routable payload',
    () async {
      await NotificationCoordinator.instance.scheduleMedication(
        occurrenceKey: 'notification-test-dose',
        scheduledAt: DateTime.now().add(const Duration(minutes: 10)),
        title: 'Medication reminder',
        body: 'Take 1 tablet.',
      );
      final args = calls.single.arguments as Map;
      final android = args['platformSpecifics'] as Map;
      final actions = (android['actions'] as List).cast<Map>();
      expect(actions.map((a) => a['id']), ['TAKEN', 'SNOOZED', 'SKIPPED']);
      expect(actions.every((a) => a['showsUserInterface'] == false), isTrue);
      final payload = NotificationPayload.parse(args['payload'] as String);
      expect(payload?.feature, 'medications');
      expect(payload?.occurrenceKey, 'notification-test-dose');
    },
  );

  test(
    'denied exact alarms fall back without losing the scheduled dose',
    () async {
      rejectExact = true;
      await NotificationCoordinator.instance.scheduleMedication(
        occurrenceKey: 'fallback-test-dose',
        scheduledAt: DateTime.now().add(const Duration(minutes: 10)),
        title: 'Medication reminder',
        body: 'Take 1 tablet.',
      );
      expect(calls.length, 2);
      final first = calls.first.arguments as Map;
      final second = calls.last.arguments as Map;
      expect(first['id'], second['id']);
      expect(first['payload'], second['payload']);
      expect(
        (first['platformSpecifics'] as Map)['scheduleMode'],
        AndroidScheduleMode.exactAllowWhileIdle.name,
      );
      expect(
        (second['platformSpecifics'] as Map)['scheduleMode'],
        AndroidScheduleMode.inexactAllowWhileIdle.name,
      );
      expect(
        (await SharedPreferences.getInstance()).getString(
          'medication_last_scheduling_error',
        ),
        contains('exact_alarms_not_permitted'),
      );
    },
  );

  test('resolving a dose cancels both due and snooze alerts', () async {
    await NotificationCoordinator.instance.cancelMedication('resolved-dose');
    expect(calls.map((c) => c.method), ['cancel', 'cancel']);
    final ids = calls.map((c) => (c.arguments as Map)['id']).toSet();
    expect(ids.length, 2);
    expect(
      ids,
      contains(
        NotificationCoordinator.instance.notificationId('resolved-dose'),
      ),
    );
  });

  test(
    'payload round-trip preserves pending action and rejects malformed data',
    () {
      const payload = NotificationPayload(
        feature: 'medications',
        occurrenceKey: 'dose',
        action: 'SNOOZED',
      );
      expect(
        NotificationPayload.parse(jsonEncode(payload.toJson()))?.action,
        'SNOOZED',
      );
      expect(NotificationPayload.parse('not-json'), isNull);
      expect(NotificationPayload.parse(null), isNull);
    },
  );
}
