import 'package:isar_community/isar.dart';

part 'medication_models.g.dart';

enum MedicationStatus { active, paused, archived }

enum MedicationFrequency {
  daily,
  weekly,
  monthly,
  annual,
  interval,
  cyclical,
  prn,
}

enum MedicationTimezoneBehavior { followDevice, fixedHome }

enum MedicationInvalidDatePolicy { lastValidDay, skip, february28 }

enum MedicationDoseOutcome { upcoming, due, snoozed, taken, skipped, missed }

enum MedicationSyncStatus {
  synced,
  pendingCreate,
  pendingUpdate,
  pendingDelete,
  failed,
}

enum MedicationPrivacyLevel { full, private, hidden }

extension MedicationDisplay on MedicationLocal {
  String get strengthLabel {
    final value = strengthValue;
    if (value == null) return '';
    final number = value == value.roundToDouble() ? value.toInt().toString() : value.toString();
    return '$number ${strengthUnit ?? ''}'.trim();
  }
}

@collection
class MedicationLocal {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  late String clientId;
  @Index(unique: true, replace: true)
  String? backendId;
  @Index(caseSensitive: false)
  late String displayName;
  String? genericName;
  String? brandName;
  double? strengthValue;
  String? strengthUnit;
  String? form;
  String? route;
  String? purpose;
  String? instructions;
  String? image;
  String? prescriber;
  String? pharmacy;
  String? notes;
  String? privateLabel;
  @enumerated
  MedicationStatus status = MedicationStatus.active;
  @enumerated
  MedicationSyncStatus syncStatus = MedicationSyncStatus.pendingCreate;
  String? syncError;
  int version = 1;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}

@embedded
class MedicationDoseSlotLocal {
  late String clientId;
  late String localTime;
  double doseQuantity = 1;
  String doseUnit = 'tablet';
  String? instructions;
}

@collection
class MedicationScheduleLocal {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  late String clientId;
  @Index()
  late String medicationClientId;
  String? backendId;
  String? seriesId;
  int revision = 1;
  @enumerated
  MedicationFrequency frequency = MedicationFrequency.daily;
  int interval = 1;
  List<int> weekdays = [];
  List<int> monthDays = [];
  String? annualDatesJson;
  int? cycleOnDays;
  int? cycleOffDays;
  String? intervalUnit;
  String? anchorLocal;
  late String timezone;
  @enumerated
  MedicationTimezoneBehavior timezoneBehavior =
      MedicationTimezoneBehavior.followDevice;
  late String startDate;
  String? endDate;
  DateTime? effectiveFrom;
  DateTime? effectiveTo;
  @enumerated
  MedicationInvalidDatePolicy invalidDatePolicy =
      MedicationInvalidDatePolicy.lastValidDay;
  bool active = true;
  List<MedicationDoseSlotLocal> slots = [];
}

@collection
class MedicationDoseRecordLocal {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  late String occurrenceKey;
  @Index()
  late String medicationClientId;
  String? scheduleClientId;
  DateTime? scheduledAt;
  String? scheduledLocal;
  late String timezone;
  @enumerated
  MedicationDoseOutcome outcome = MedicationDoseOutcome.upcoming;
  DateTime? takenAt;
  DateTime recordedAt = DateTime.now();
  DateTime? snoozedUntil;
  double doseQuantity = 1;
  double supplyDeductedQuantity = 0;
  String doseUnit = 'tablet';
  String? instructions;
  String? note;
  int version = 1;
  bool corrected = false;
  bool pendingSync = true;
}

@collection
class MedicationDoseActionLocal {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  late String clientOperationId;
  @Index()
  late String occurrenceKey;
  late String action;
  late DateTime actedAt;
  DateTime createdAt = DateTime.now();
  String? note;
}

@collection
class MedicationSupplyLocal {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  late String medicationClientId;
  double quantity = 0;
  String unit = 'tablet';
  double? refillThreshold;
  DateTime? refillDate;
  DateTime? prescriptionExpiry;
  int version = 1;
}

@collection
class MedicationPendingOperation {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  late String clientOperationId;
  late String operationType;
  late String bodyJson;
  int attemptCount = 0;
  DateTime? nextRetryAt;
  String? lastError;
  DateTime createdAt = DateTime.now();
}

class MedicationOccurrence {
  final String occurrenceKey;
  final MedicationLocal medication;
  final MedicationScheduleLocal? schedule;
  final MedicationDoseSlotLocal slot;
  final DateTime? scheduledAt;
  final String scheduledLocal;
  final MedicationDoseOutcome outcome;
  final MedicationDoseRecordLocal? record;

  const MedicationOccurrence({
    required this.occurrenceKey,
    required this.medication,
    required this.schedule,
    required this.slot,
    required this.scheduledAt,
    required this.scheduledLocal,
    required this.outcome,
    this.record,
  });

  MedicationOccurrence copyWith({
    MedicationDoseOutcome? outcome,
    MedicationDoseRecordLocal? record,
  }) => MedicationOccurrence(
    occurrenceKey: occurrenceKey,
    medication: medication,
    schedule: schedule,
    slot: slot,
    scheduledAt: scheduledAt,
    scheduledLocal: scheduledLocal,
    outcome: outcome ?? this.outcome,
    record: record ?? this.record,
  );
}
