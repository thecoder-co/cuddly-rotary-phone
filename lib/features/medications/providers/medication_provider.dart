import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/services/local_data/local_data.dart';
import '../models/medication_models.dart';
import '../repo/local_medication_repo.dart';
import '../repo/medication_repo.dart';
import '../services/medication_recurrence_engine.dart';
import '../services/medication_sync_service.dart';
import '../services/medication_reminder_scheduler.dart';
import '../../../core/services/notifications/notification_coordinator.dart';

class MedicationAccount extends Notifier<String?> {
  @override
  String? build() {
    final subscription = LocalData.accountChanges.stream.listen((value) {
      if (value != state) state = value;
    });
    ref.onDispose(subscription.cancel);
    return LocalData.userId;
  }
}

final medicationAccountProvider = NotifierProvider<MedicationAccount, String?>(
  MedicationAccount.new,
);
final localMedicationRepoProvider = Provider((ref) {
  ref.watch(medicationAccountProvider);
  return LocalMedicationRepo();
});
final medicationCloudRepoProvider = Provider((ref) {
  ref.watch(medicationAccountProvider);
  return MedicationCloudRepo();
});
final medicationSyncServiceProvider = Provider((ref) {
  final service = MedicationSyncService(
    local: ref.watch(localMedicationRepoProvider),
    cloud: ref.watch(medicationCloudRepoProvider),
  );
  final timer = Timer.periodic(const Duration(seconds: 30), (_) {
    if (WidgetsBinding.instance.lifecycleState != AppLifecycleState.resumed) {
      return;
    }
    // Retry durable uploads only. An empty queue causes no network requests.
    unawaited(service.syncPending(pullRemote: false));
  });
  final lifecycle = AppLifecycleListener(
    onResume: () {
      unawaited(service.syncPending(retryNow: true));
    },
  );
  ref.onDispose(timer.cancel);
  ref.onDispose(lifecycle.dispose);
  return service;
});
final medicationReminderSchedulerProvider = Provider(
  (ref) => MedicationReminderScheduler(
    local: ref.watch(localMedicationRepoProvider),
    notifications: NotificationCoordinator.instance,
  ),
);
final medicationsProvider = StreamProvider<List<MedicationLocal>>((ref) {
  final repo = ref.watch(localMedicationRepoProvider);
  return repo.watchMedications();
});
final medicationByIdProvider = FutureProvider.family<MedicationLocal?, String>(
  (ref, id) => ref.watch(localMedicationRepoProvider).getMedication(id),
);

final todayMedicationProvider = StreamProvider.autoDispose
    .family<List<MedicationOccurrence>, DateTime>((ref, date) async* {
      final repo = ref.watch(localMedicationRepoProvider);
      const engine = MedicationRecurrenceEngine();
      await for (final _ in repo.watchDoseChanges()) {
        final from = DateTime(date.year, date.month, date.day);
        final to = from
            .add(const Duration(days: 1))
            .subtract(const Duration(milliseconds: 1));
        final records = await repo.recordsBetween(
          from.subtract(const Duration(days: 1)),
          to.add(const Duration(days: 1)),
        );
        final occurrences = <MedicationOccurrence>[];
        for (final medication in await repo.getActiveMedications()) {
          for (final schedule in await repo.schedulesFor(medication.clientId)) {
            occurrences.addAll(
              engine.expand(
                userId: LocalData.userId ?? 'local-user',
                medication: medication,
                schedule: schedule,
                from: from,
                to: to,
                records: records,
              ),
            );
          }
        }
        occurrences.sort((a, b) => a.scheduledAt!.compareTo(b.scheduledAt!));
        yield occurrences;
      }
    });

final medicationHistoryProvider =
    StreamProvider<List<MedicationDoseRecordLocal>>((ref) async* {
      final repo = ref.watch(localMedicationRepoProvider);
      await for (final _ in repo.watchDoseChanges()) {
        yield await repo.allRecords();
      }
    });

final medicationActionsProvider = Provider((ref) => MedicationActions(ref));

class MedicationActions {
  final Ref ref;
  static const _uuid = Uuid();
  MedicationActions(this.ref);

  Future<void> refreshReminders() =>
      ref.read(medicationReminderSchedulerProvider).rescheduleAll();

  Future<void> create({
    required MedicationLocal medication,
    required List<MedicationScheduleLocal> schedules,
    MedicationSupplyLocal? supply,
  }) async {
    await ref
        .read(localMedicationRepoProvider)
        .createMedication(
          medication: medication,
          schedules: schedules,
          supply: supply,
        );
    await ref
        .read(medicationReminderSchedulerProvider)
        .rescheduleMedication(medication);
    unawaited(ref.read(medicationSyncServiceProvider).syncPending());
  }

  Future<MedicationDoseRecordLocal> record(
    MedicationOccurrence occurrence,
    MedicationDoseOutcome outcome, {
    DateTime? actedAt,
    DateTime? snoozedUntil,
    String? note,
  }) async {
    final record = await ref
        .read(localMedicationRepoProvider)
        .recordAction(
          occurrence: occurrence,
          clientOperationId: _uuid.v4(),
          outcome: outcome,
          actedAt: actedAt ?? DateTime.now(),
          snoozedUntil: snoozedUntil,
          note: note,
        );
    await ref
        .read(medicationReminderSchedulerProvider)
        .resolve(
          occurrence,
          snoozedUntil: outcome == MedicationDoseOutcome.snoozed
              ? snoozedUntil
              : null,
        );
    unawaited(ref.read(medicationSyncServiceProvider).syncPending());
    return record;
  }

  Future<void> update({
    required MedicationLocal medication,
    required MedicationScheduleLocal schedule,
  }) async {
    await ref
        .read(localMedicationRepoProvider)
        .updateMedication(medication: medication, schedule: schedule);
    await ref.read(medicationReminderSchedulerProvider).rescheduleAll();
    ref.invalidate(medicationByIdProvider(medication.clientId));
    unawaited(ref.read(medicationSyncServiceProvider).syncPending());
  }

  Future<void> setStatus(
    MedicationLocal medication,
    MedicationStatus status,
  ) async {
    await ref
        .read(localMedicationRepoProvider)
        .updateStatus(medication, status);
    ref.invalidate(medicationByIdProvider(medication.clientId));
    if (status == MedicationStatus.active) {
      await ref
          .read(medicationReminderSchedulerProvider)
          .rescheduleMedication(medication);
    } else {
      await ref
          .read(medicationReminderSchedulerProvider)
          .cancelMedication(medication.clientId);
    }
    unawaited(ref.read(medicationSyncServiceProvider).syncPending());
  }

  Future<void> adjustSupply(
    MedicationLocal medication, {
    required double delta,
    required bool refill,
    String? reason,
  }) async {
    await ref
        .read(localMedicationRepoProvider)
        .adjustSupply(
          medicationClientId: medication.clientId,
          clientOperationId: _uuid.v4(),
          delta: delta,
          type: refill ? 'REFILL' : 'ADJUSTMENT',
          reason: reason,
        );
    unawaited(ref.read(medicationSyncServiceProvider).syncPending());
  }

  Future<void> clearMedicationData() async {
    final medications = await ref
        .read(localMedicationRepoProvider)
        .getActiveMedications();
    for (final medication in medications) {
      await ref
          .read(medicationReminderSchedulerProvider)
          .cancelMedication(medication.clientId);
    }
    await ref.read(localMedicationRepoProvider).clearMedicationData(_uuid.v4());
    unawaited(ref.read(medicationSyncServiceProvider).syncPending());
  }
}
