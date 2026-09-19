import 'dart:io';
import '../../../core/services/local_data/local_data.dart';
import '../../../core/services/notifications/notification_coordinator.dart';
import '../models/medication_models.dart';
import '../repo/local_medication_repo.dart';
import 'medication_recurrence_engine.dart';

class MedicationReminderScheduler {
  final LocalMedicationRepo local;
  final NotificationCoordinator notifications;
  const MedicationReminderScheduler({
    required this.local,
    required this.notifications,
  });

  Future<void> rescheduleMedication(MedicationLocal medication) async {
    await rescheduleAll();
  }

  Future<void> rescheduleAll() async {
    final medications = await local.getActiveMedications();
    final records = await local.allRecords();
    final enabled = LocalData.prefs.getBool('medication_reminders') ?? true;
    final activeIds = (await notifications.plugin.getActiveNotifications())
        .map((notification) => notification.id)
        .toSet();
    final keys = <String, List<String>>{};
    // Rebuild future alarms without dismissing already-delivered unanswered
    // doses. Keep their keys tracked so archive/disable still cancels them.
    for (final preference
        in LocalData.prefs
            .getKeys()
            .where((key) => key.startsWith('medication_scheduled_'))
            .toList()) {
      final clientId = preference.substring('medication_scheduled_'.length);
      final activeMedication = medications.any((m) => m.clientId == clientId);
      for (final key
          in LocalData.prefs.getStringList(preference) ?? <String>[]) {
        final resolved = records.any(
          (r) =>
              r.occurrenceKey == key &&
              (r.outcome == MedicationDoseOutcome.taken ||
                  r.outcome == MedicationDoseOutcome.skipped),
        );
        final delivered =
            activeIds.contains(notifications.notificationId(key)) ||
            activeIds.contains(notifications.notificationId(key, offset: 1));
        if (enabled && activeMedication && delivered && !resolved) {
          (keys[clientId] ??= []).add(key);
        } else {
          await notifications.cancelMedication(key);
        }
      }
      await LocalData.prefs.remove(preference);
    }
    if (!enabled) return;
    final now = DateTime.now();
    final horizon = now.add(Duration(days: Platform.isAndroid ? 30 : 90));
    final occurrences = <MedicationOccurrence>[];
    for (final medication in medications) {
      for (final schedule in await local.schedulesFor(medication.clientId)) {
        occurrences.addAll(
          const MedicationRecurrenceEngine()
              .expand(
                userId: LocalData.userId ?? 'local-user',
                medication: medication,
                schedule: schedule,
                from: now,
                to: horizon,
                records: records,
              )
              .where(
                (item) =>
                    item.outcome == MedicationDoseOutcome.upcoming ||
                    item.outcome == MedicationDoseOutcome.due,
              ),
        );
      }
    }
    occurrences.sort((a, b) => a.scheduledAt!.compareTo(b.scheduledAt!));
    final existing = await notifications.plugin.pendingNotificationRequests();
    var remaining = Platform.isIOS ? (60 - existing.length).clamp(0, 60) : 200;
    final privacy =
        LocalData.prefs.getString('medication_privacy') ?? 'Private';
    for (final record in records) {
      if (remaining == 0) break;
      if (record.outcome != MedicationDoseOutcome.snoozed ||
          record.snoozedUntil?.isAfter(now) != true ||
          !medications.any(
            (m) =>
                m.clientId == record.medicationClientId &&
                m.status == MedicationStatus.active,
          ))
        continue;
      await notifications.scheduleMedication(
        occurrenceKey: record.occurrenceKey,
        scheduledAt: record.snoozedUntil!,
        title: 'Medication follow-up',
        body: 'This snoozed dose is waiting for an outcome.',
        ongoing: Platform.isAndroid,
      );
      (keys[record.medicationClientId] ??= []).add(record.occurrenceKey);
      remaining--;
    }
    for (final occurrence in occurrences.take(remaining)) {
      final medication = occurrence.medication;
      final title = privacy == 'Hidden'
          ? 'Health reminder'
          : privacy == 'Full'
          ? medication.displayName
          : 'Medication reminder';
      final body = privacy == 'Hidden'
          ? 'You have a health reminder.'
          : privacy == 'Full'
          ? 'Take ${occurrence.slot.doseQuantity.g} ${occurrence.slot.doseUnit}${occurrence.slot.instructions?.isNotEmpty == true ? ' • ${occurrence.slot.instructions}' : ''}'
          : 'Take ${occurrence.slot.doseQuantity.g} ${occurrence.slot.doseUnit}.';
      await notifications.scheduleMedication(
        occurrenceKey: occurrence.occurrenceKey,
        scheduledAt: occurrence.scheduledAt!,
        title: title,
        body: body,
      );
      (keys[medication.clientId] ??= []).add(occurrence.occurrenceKey);
    }
    for (final entry in keys.entries) {
      await LocalData.prefs.setStringList(
        'medication_scheduled_${entry.key}',
        entry.value,
      );
    }
  }

  Future<void> cancelMedication(String clientId) async {
    final keys =
        LocalData.prefs.getStringList('medication_scheduled_$clientId') ??
        const [];
    for (final key in keys) {
      await notifications.cancelMedication(key);
    }
    await LocalData.prefs.remove('medication_scheduled_$clientId');
  }

  Future<void> resolve(
    MedicationOccurrence occurrence, {
    DateTime? snoozedUntil,
  }) async {
    await notifications.cancelMedication(occurrence.occurrenceKey);
    if (snoozedUntil != null)
      await notifications.scheduleMedication(
        occurrenceKey: occurrence.occurrenceKey,
        scheduledAt: snoozedUntil,
        title: 'Medication follow-up',
        body: 'This snoozed dose is waiting for an outcome.',
        ongoing: Platform.isAndroid,
      );
  }
}

extension _DoseFormat on double {
  String get g => this == roundToDouble() ? toInt().toString() : toString();
}
