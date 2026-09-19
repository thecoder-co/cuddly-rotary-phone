import 'dart:async';
import 'dart:convert';
import 'package:isar_community/isar.dart';
import '../../../core/services/local_data/isar_service.dart';
import '../models/medication_models.dart';

class LocalMedicationRepo {
  final Isar isar;
  LocalMedicationRepo({Isar? isarInstance})
    : isar = isarInstance ?? IsarService.medicationIsar;

  Stream<List<MedicationLocal>> watchMedications() async* {
    yield await isar.medicationLocals.where().sortByDisplayName().findAll();
    await for (final _ in isar.medicationLocals.watchLazy()) {
      yield await isar.medicationLocals.where().sortByDisplayName().findAll();
    }
  }

  Future<List<MedicationLocal>> _activeMedications() => isar.medicationLocals
      .filter()
      .not()
      .statusEqualTo(MedicationStatus.archived)
      .sortByDisplayName()
      .findAll();
  Future<List<MedicationLocal>> getActiveMedications() => _activeMedications();
  Future<List<MedicationScheduleLocal>> schedulesFor(String clientId) => isar
      .medicationScheduleLocals
      .filter()
      .medicationClientIdEqualTo(clientId)
      .activeEqualTo(true)
      .sortByRevisionDesc()
      .findAll();
  Future<List<MedicationDoseRecordLocal>> recordsBetween(
    DateTime from,
    DateTime to,
  ) => isar.medicationDoseRecordLocals
      .filter()
      .scheduledAtBetween(from, to)
      .findAll();
  Future<List<MedicationDoseRecordLocal>> allRecords() =>
      isar.medicationDoseRecordLocals.where().sortByRecordedAtDesc().findAll();
  Stream<void> watchDoseChanges() {
    final subscriptions = <StreamSubscription<void>>[];
    late StreamController<void> controller;
    controller = StreamController<void>(
      onListen: () {
        for (final stream in [
          isar.medicationDoseRecordLocals.watchLazy(),
          isar.medicationLocals.watchLazy(),
          isar.medicationScheduleLocals.watchLazy(),
        ]) {
          subscriptions.add(stream.listen((_) => controller.add(null)));
        }
        controller.add(null);
      },
      onCancel: () async {
        await Future.wait(
          subscriptions.map((subscription) => subscription.cancel()),
        );
      },
    );
    return controller.stream;
  }

  Future<MedicationLocal?> getMedication(String clientId) =>
      isar.medicationLocals.getByClientId(clientId);
  Future<MedicationScheduleLocal?> getSchedule(String clientId) =>
      isar.medicationScheduleLocals.getByClientId(clientId);
  Future<MedicationSupplyLocal?> supplyFor(String clientId) =>
      isar.medicationSupplyLocals.getByMedicationClientId(clientId);

  Future<void> adjustSupply({
    required String medicationClientId,
    required String clientOperationId,
    required double delta,
    required String type,
    String? reason,
  }) async {
    final supply = await supplyFor(medicationClientId);
    if (supply == null) throw StateError('Supply tracking is not enabled');
    supply.quantity = (supply.quantity + delta).clamp(0, double.infinity);
    supply.version += 1;
    await isar.writeTxn(() async {
      await isar.medicationSupplyLocals.put(supply);
      await isar.medicationPendingOperations.put(
        MedicationPendingOperation()
          ..clientOperationId = clientOperationId
          ..operationType = 'SUPPLY_ADJUSTMENT'
          ..bodyJson = jsonEncode({
            'medicationClientId': medicationClientId,
            'clientOperationId': clientOperationId,
            'type': type,
            'delta': delta.toString(),
            'reason': reason,
          }),
      );
    });
  }

  Future<void> clearMedicationData(String clientOperationId) async {
    await isar.writeTxn(() async {
      await isar.medicationDoseActionLocals.clear();
      await isar.medicationDoseRecordLocals.clear();
      await isar.medicationSupplyLocals.clear();
      await isar.medicationScheduleLocals.clear();
      await isar.medicationLocals.clear();
      await isar.medicationPendingOperations.clear();
      await isar.medicationPendingOperations.put(
        MedicationPendingOperation()
          ..clientOperationId = clientOperationId
          ..operationType = 'DELETE_ALL'
          ..bodyJson = '{}',
      );
    });
  }

  Future<void> createMedication({
    required MedicationLocal medication,
    required List<MedicationScheduleLocal> schedules,
    MedicationSupplyLocal? supply,
  }) async {
    final body = _createBody(medication, schedules, supply);
    await isar.writeTxn(() async {
      await isar.medicationLocals.put(medication);
      await isar.medicationScheduleLocals.putAll(schedules);
      if (supply != null) await isar.medicationSupplyLocals.put(supply);
      await isar.medicationPendingOperations.put(
        MedicationPendingOperation()
          ..clientOperationId = medication.clientId
          ..operationType = 'CREATE_MEDICATION'
          ..bodyJson = jsonEncode(body),
      );
    });
  }

  Future<void> updateStatus(
    MedicationLocal medication,
    MedicationStatus status,
  ) async {
    medication.status = status;
    medication.version += 1;
    medication.updatedAt = DateTime.now();
    medication.syncStatus = MedicationSyncStatus.pendingUpdate;
    final operation = MedicationPendingOperation()
      ..clientOperationId =
          '${medication.clientId}-status-${DateTime.now().microsecondsSinceEpoch}'
      ..operationType = 'STATUS'
      ..bodyJson = jsonEncode({
        'medicationClientId': medication.clientId,
        'status': status.name,
      });
    await isar.writeTxn(() async {
      await isar.medicationLocals.put(medication);
      await isar.medicationPendingOperations.put(operation);
    });
  }

  Future<void> updateMedication({
    required MedicationLocal medication,
    required MedicationScheduleLocal schedule,
  }) async {
    final previousSchedules = await schedulesFor(medication.clientId);
    for (final previous in previousSchedules) {
      previous.effectiveTo ??= schedule.effectiveFrom ?? DateTime.now();
    }
    final body = _createBody(medication, [schedule], null)
      ..['version'] = medication.version;
    medication.version += 1;
    medication.updatedAt = DateTime.now();
    medication.syncStatus = MedicationSyncStatus.pendingUpdate;
    await isar.writeTxn(() async {
      await isar.medicationLocals.put(medication);
      await isar.medicationScheduleLocals.putAll(previousSchedules);
      await isar.medicationScheduleLocals.put(schedule);
      await isar.medicationPendingOperations.put(
        MedicationPendingOperation()
          ..clientOperationId = schedule.clientId
          ..operationType = 'UPDATE_MEDICATION'
          ..bodyJson = jsonEncode(body),
      );
    });
  }

  Future<MedicationDoseRecordLocal> recordAction({
    required MedicationOccurrence occurrence,
    required String clientOperationId,
    required MedicationDoseOutcome outcome,
    required DateTime actedAt,
    DateTime? snoozedUntil,
    String? note,
  }) async => isar.writeTxn(() async {
    final existingAction = await isar.medicationDoseActionLocals
        .getByClientOperationId(clientOperationId);
    if (existingAction != null)
      return (await isar.medicationDoseRecordLocals.getByOccurrenceKey(
        occurrence.occurrenceKey,
      ))!;
    final prior = await isar.medicationDoseRecordLocals.getByOccurrenceKey(
      occurrence.occurrenceKey,
    );
    final previousOutcome = prior?.outcome;
    final wasTaken = previousOutcome == MedicationDoseOutcome.taken;
    final record =
        prior ??
        (MedicationDoseRecordLocal()
          ..occurrenceKey = occurrence.occurrenceKey
          ..medicationClientId = occurrence.medication.clientId
          ..scheduleClientId = occurrence.schedule?.clientId
          ..scheduledAt = occurrence.scheduledAt
          ..scheduledLocal = occurrence.scheduledLocal
          ..timezone = occurrence.schedule?.timezone ?? 'UTC'
          ..doseQuantity = occurrence.slot.doseQuantity
          ..doseUnit = occurrence.slot.doseUnit
          ..instructions =
              occurrence.slot.instructions ??
              occurrence.medication.instructions);
    record.outcome = outcome;
    record.takenAt = outcome == MedicationDoseOutcome.taken ? actedAt : null;
    record.snoozedUntil = snoozedUntil;
    record.note = note;
    record.recordedAt = actedAt;
    record.version += prior == null ? 0 : 1;
    record.corrected =
        record.corrected ||
        (previousOutcome != null && previousOutcome != outcome);
    record.pendingSync = true;
    final action = MedicationDoseActionLocal()
      ..clientOperationId = clientOperationId
      ..occurrenceKey = occurrence.occurrenceKey
      ..action = outcome.name.toUpperCase()
      ..actedAt = actedAt
      ..note = note;
    final operationBody = {
      'clientOperationId': clientOperationId,
      'occurrenceKey': occurrence.occurrenceKey,
      'medicationClientId': occurrence.medication.clientId,
      'scheduleClientId': occurrence.schedule?.clientId,
      'action': outcome.name.toUpperCase(),
      'scheduledAt': occurrence.scheduledAt?.toUtc().toIso8601String(),
      'scheduledLocal': occurrence.scheduledLocal,
      'timezone': record.timezone,
      'actedAt': actedAt.toUtc().toIso8601String(),
      'doseQuantity': occurrence.slot.doseQuantity.toString(),
      'doseUnit': occurrence.slot.doseUnit,
      'note': note,
      'snoozedUntil': snoozedUntil?.toUtc().toIso8601String(),
    };
    await isar.medicationDoseRecordLocals.put(record);
    await isar.medicationDoseActionLocals.put(action);
    await isar.medicationPendingOperations.put(
      MedicationPendingOperation()
        ..clientOperationId = clientOperationId
        ..operationType = 'DOSE_ACTION'
        ..bodyJson = jsonEncode(operationBody),
    );
    final isTaken = outcome == MedicationDoseOutcome.taken;
    if (wasTaken != isTaken) {
      final supply = await isar.medicationSupplyLocals.getByMedicationClientId(
        occurrence.medication.clientId,
      );
      if (supply != null) {
        final available = supply.quantity + record.supplyDeductedQuantity;
        record.supplyDeductedQuantity = isTaken
            ? occurrence.slot.doseQuantity.clamp(0, available)
            : 0;
        supply.quantity = available - record.supplyDeductedQuantity;
        supply.version += 1;
        await isar.medicationDoseRecordLocals.put(record);
        await isar.medicationSupplyLocals.put(supply);
      }
    }
    return record;
  });

  Future<List<MedicationPendingOperation>> pendingOperations() =>
      isar.medicationPendingOperations.where().sortByCreatedAt().findAll();

  Future<void> mergeRemoteData(
    List<Map<String, dynamic>> medications,
    List<Map<String, dynamic>> records,
  ) async {
    final medicationRows = <MedicationLocal>[];
    final scheduleRows = <MedicationScheduleLocal>[];
    final supplyRows = <MedicationSupplyLocal>[];
    final recordRows = <MedicationDoseRecordLocal>[];
    for (final remote in medications) {
      final clientId = remote['id'] as String;
      final medication = await getMedication(clientId) ?? MedicationLocal();
      medication
        ..clientId = clientId
        ..backendId = clientId
        ..displayName = remote['displayName'] as String
        ..genericName = remote['genericName'] as String?
        ..brandName = remote['brandName'] as String?
        ..strengthValue = double.tryParse('${remote['strengthValue']}')
        ..strengthUnit = remote['strengthUnit'] as String?
        ..form = remote['form'] as String?
        ..route = remote['route'] as String?
        ..purpose = remote['purpose'] as String?
        ..instructions = remote['instructions'] as String?
        ..image = remote['image'] as String?
        ..prescriber = remote['prescriber'] as String?
        ..pharmacy = remote['pharmacy'] as String?
        ..notes = remote['notes'] as String?
        ..privateLabel = remote['privateLabel'] as String?
        ..status = MedicationStatus.values.byName(
          (remote['status'] as String).toLowerCase(),
        )
        ..version = remote['version'] as int
        ..syncStatus = MedicationSyncStatus.synced;
      medicationRows.add(medication);
      for (final series in remote['schedules'] as List? ?? const []) {
        for (final revision in series['revisions'] as List? ?? const []) {
          final schedule =
              await getSchedule(revision['id'] as String) ??
              MedicationScheduleLocal();
          final rule = revision['rule'] as Map;
          schedule
            ..clientId = revision['id'] as String
            ..backendId = revision['id'] as String
            ..seriesId = series['id'] as String
            ..medicationClientId = clientId
            ..revision = revision['revision'] as int
            ..frequency = MedicationFrequency.values.byName(
              (revision['frequency'] as String).toLowerCase(),
            )
            ..interval = rule['interval'] as int? ?? 1
            ..weekdays = List<int>.from(rule['weekdays'] as List? ?? const [])
            ..monthDays = List<int>.from(rule['monthDays'] as List? ?? const [])
            ..annualDatesJson = rule['annualDates'] == null
                ? null
                : jsonEncode(rule['annualDates'])
            ..cycleOnDays = rule['cycleOnDays'] as int?
            ..cycleOffDays = rule['cycleOffDays'] as int?
            ..intervalUnit = rule['intervalUnit'] as String?
            ..anchorLocal = rule['anchorLocal'] as String?
            ..timezone = revision['timezone'] as String
            ..timezoneBehavior = revision['timezoneBehavior'] == 'FIXED_HOME'
                ? MedicationTimezoneBehavior.fixedHome
                : MedicationTimezoneBehavior.followDevice
            ..startDate = revision['startDate'] as String
            ..endDate = revision['endDate'] as String?
            ..effectiveFrom = DateTime.tryParse('${revision['effectiveFrom']}')
            ..effectiveTo = DateTime.tryParse('${revision['effectiveTo']}')
            ..invalidDatePolicy = switch (revision['invalidDatePolicy']) {
              'SKIP' => MedicationInvalidDatePolicy.skip,
              'FEBRUARY_28' => MedicationInvalidDatePolicy.february28,
              _ => MedicationInvalidDatePolicy.lastValidDay,
            }
            ..active = true
            ..slots = (revision['slots'] as List)
                .map(
                  (slot) => MedicationDoseSlotLocal()
                    ..clientId = slot['id'] as String
                    ..localTime = slot['localTime'] as String
                    ..doseQuantity = double.parse('${slot['doseQuantity']}')
                    ..doseUnit = slot['doseUnit'] as String
                    ..instructions = slot['instructionOverride'] as String?,
                )
                .toList();
          scheduleRows.add(schedule);
        }
      }
      final remoteSupply = remote['supply'] as Map?;
      if (remoteSupply != null) {
        final supply = await supplyFor(clientId) ?? MedicationSupplyLocal();
        supply
          ..medicationClientId = clientId
          ..quantity = double.parse('${remoteSupply['quantity']}')
          ..unit = remoteSupply['unit'] as String
          ..refillThreshold = double.tryParse(
            '${remoteSupply['refillThreshold']}',
          )
          ..version = remoteSupply['version'] as int;
        supplyRows.add(supply);
      }
    }
    for (final remote in records) {
      final record =
          await isar.medicationDoseRecordLocals.getByOccurrenceKey(
            remote['occurrenceKey'] as String,
          ) ??
          MedicationDoseRecordLocal();
      record
        ..occurrenceKey = remote['occurrenceKey'] as String
        ..medicationClientId = remote['medicationId'] as String
        ..scheduleClientId = remote['scheduleRevisionId'] as String?
        ..scheduledAt = DateTime.tryParse('${remote['scheduledAt']}')
        ..scheduledLocal = remote['scheduledLocal'] as String?
        ..timezone = remote['timezone'] as String
        ..outcome = MedicationDoseOutcome.values.byName(
          (remote['outcome'] as String).toLowerCase(),
        )
        ..takenAt = DateTime.tryParse('${remote['takenAt']}')
        ..recordedAt = DateTime.parse(remote['recordedAt'] as String)
        ..snoozedUntil = DateTime.tryParse('${remote['snoozedUntil']}')
        ..doseQuantity = double.parse('${remote['doseQuantity']}')
        ..supplyDeductedQuantity =
            double.tryParse('${remote['supplyDeductedQuantity']}') ?? 0
        ..doseUnit = remote['doseUnit'] as String
        ..instructions = remote['instructions'] as String?
        ..note = remote['note'] as String?
        ..version = remote['version'] as int
        ..corrected = remote['corrected'] as bool
        ..pendingSync = false;
      recordRows.add(record);
    }
    await isar.writeTxn(() async {
      if (await isar.medicationPendingOperations.count() > 0) return;
      await isar.medicationLocals.putAll(medicationRows);
      await isar.medicationScheduleLocals.putAll(scheduleRows);
      await isar.medicationSupplyLocals.putAll(supplyRows);
      await isar.medicationDoseRecordLocals.putAll(recordRows);
    });
  }

  Future<void> completeOperation(int id) =>
      isar.writeTxn(() => isar.medicationPendingOperations.delete(id));
  Future<void> failOperation(
    MedicationPendingOperation operation,
    Object error,
  ) async {
    operation.attemptCount += 1;
    operation.lastError = error.toString();
    operation.nextRetryAt = DateTime.now().add(
      Duration(minutes: operation.attemptCount.clamp(1, 60)),
    );
    await isar.writeTxn(() => isar.medicationPendingOperations.put(operation));
  }

  Future<void> applyCreatedMedication(
    String clientId,
    Map<String, dynamic> response,
  ) async {
    if (response['id'] != clientId || response['version'] is! int) {
      throw StateError(
        'Invalid medication acknowledgement; change retained for retry.',
      );
    }
    final medication = await getMedication(clientId);
    if (medication == null) return;
    medication.backendId = response['id'] as String;
    medication.version = response['version'] as int? ?? 1;
    medication.syncStatus = MedicationSyncStatus.synced;
    final localSchedules = await schedulesFor(clientId);
    final remoteSchedules = (response['schedules'] as List? ?? const [])
        .cast<Map<String, dynamic>>();
    for (final localSchedule in localSchedules) {
      for (final remote in remoteSchedules) {
        if (remote['id'] != localSchedule.seriesId) continue;
        final revisions = (remote['revisions'] as List? ?? const []);
        for (final revision in revisions) {
          if (revision['id'] == localSchedule.clientId ||
              revision['revision'] == localSchedule.revision) {
            localSchedule.backendId = revision['id'] as String?;
            break;
          }
        }
      }
    }
    await isar.writeTxn(() async {
      await isar.medicationLocals.put(medication);
      await isar.medicationScheduleLocals.putAll(localSchedules);
    });
  }

  Map<String, dynamic> _createBody(
    MedicationLocal m,
    List<MedicationScheduleLocal> schedules,
    MedicationSupplyLocal? supply,
  ) => {
    'clientId': m.clientId,
    'displayName': m.displayName,
    'genericName': m.genericName,
    'brandName': m.brandName,
    'strengthValue': m.strengthValue?.toString(),
    'strengthUnit': m.strengthUnit,
    'form': m.form,
    'route': m.route,
    'purpose': m.purpose,
    'instructions': m.instructions,
    'image': m.image,
    'prescriber': m.prescriber,
    'pharmacy': m.pharmacy,
    'notes': m.notes,
    'privateLabel': m.privateLabel,
    'schedules': schedules
        .map(
          (s) => {
            'clientId': s.clientId,
            'seriesId': s.seriesId ?? s.clientId,
            'rule': {
              'schemaVersion': 1,
              'frequency': s.frequency.name.toUpperCase(),
              'interval': s.interval,
              if (s.weekdays.isNotEmpty) 'weekdays': s.weekdays,
              if (s.monthDays.isNotEmpty) 'monthDays': s.monthDays,
              if (s.annualDatesJson != null)
                'annualDates': jsonDecode(s.annualDatesJson!),
              if (s.cycleOnDays != null) 'cycleOnDays': s.cycleOnDays,
              if (s.cycleOffDays != null) 'cycleOffDays': s.cycleOffDays,
              if (s.intervalUnit != null) 'intervalUnit': s.intervalUnit,
              if (s.anchorLocal != null) 'anchorLocal': s.anchorLocal,
            },
            'timezone': s.timezone,
            'timezoneBehavior':
                s.timezoneBehavior == MedicationTimezoneBehavior.followDevice
                ? 'FOLLOW_DEVICE'
                : 'FIXED_HOME',
            'startDate': s.startDate,
            'endDate': s.endDate,
            'invalidDatePolicy': switch (s.invalidDatePolicy) {
              MedicationInvalidDatePolicy.skip => 'SKIP',
              MedicationInvalidDatePolicy.february28 => 'FEBRUARY_28',
              _ => 'LAST_VALID_DAY',
            },
            'slots': s.slots
                .map(
                  (slot) => {
                    'localTime': slot.localTime,
                    'doseQuantity': slot.doseQuantity.toString(),
                    'doseUnit': slot.doseUnit,
                    'instructionOverride': slot.instructions,
                  },
                )
                .toList(),
          },
        )
        .toList(),
    if (supply != null)
      'supply': {
        'quantity': supply.quantity.toString(),
        'unit': supply.unit,
        'refillThreshold': supply.refillThreshold?.toString(),
        'refillDate': supply.refillDate?.toIso8601String(),
        'prescriptionExpiry': supply.prescriptionExpiry?.toIso8601String(),
      },
  };
}
