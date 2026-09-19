import 'package:calorie_tracker/features/medications/models/medication_models.dart';
import 'package:calorie_tracker/features/medications/services/medication_recurrence_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;

void main() {
  setUpAll(tz_data.initializeTimeZones);
  test('weekly Monday Wednesday Friday at two times creates six doses', () {
    final medication = MedicationLocal()
      ..clientId = 'med-1'
      ..displayName = 'Test';
    final schedule = MedicationScheduleLocal()
      ..clientId = 'schedule-1'
      ..seriesId = 'series-1'
      ..medicationClientId = medication.clientId
      ..frequency = MedicationFrequency.weekly
      ..weekdays = [1, 3, 5]
      ..timezone = 'Africa/Lagos'
      ..startDate = '2026-09-07'
      ..slots = [
        MedicationDoseSlotLocal()
          ..clientId = 'a'
          ..localTime = '08:00'
          ..doseQuantity = 1
          ..doseUnit = 'tablet',
        MedicationDoseSlotLocal()
          ..clientId = 'b'
          ..localTime = '20:00'
          ..doseQuantity = 1
          ..doseUnit = 'tablet',
      ];
    final values = const MedicationRecurrenceEngine().expand(
      userId: 'user-1',
      medication: medication,
      schedule: schedule,
      from: DateTime.utc(2026, 9, 6),
      to: DateTime.utc(2026, 9, 13, 23, 59),
    );
    expect(values, hasLength(6));
    expect(values.map((item) => item.occurrenceKey).toSet(), hasLength(6));
  });
  test('monthly day 31 uses last valid day', () {
    final medication = MedicationLocal()
      ..clientId = 'med'
      ..displayName = 'Test';
    final schedule = MedicationScheduleLocal()
      ..clientId = 'schedule'
      ..seriesId = 'series'
      ..medicationClientId = 'med'
      ..frequency = MedicationFrequency.monthly
      ..monthDays = [31]
      ..timezone = 'Africa/Lagos'
      ..startDate = '2026-01-31'
      ..invalidDatePolicy = MedicationInvalidDatePolicy.lastValidDay
      ..slots = [
        MedicationDoseSlotLocal()
          ..clientId = 'slot'
          ..localTime = '08:00'
          ..doseQuantity = 1
          ..doseUnit = 'tablet',
      ];
    final values = const MedicationRecurrenceEngine().expand(
      userId: 'user',
      medication: medication,
      schedule: schedule,
      from: DateTime.utc(2026, 2, 1),
      to: DateTime.utc(2026, 3, 1),
    );
    expect(values.single.scheduledLocal.startsWith('2026-02-28'), isTrue);
  });
}
