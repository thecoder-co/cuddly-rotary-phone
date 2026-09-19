import 'dart:convert';
import 'dart:io';
import 'package:calorie_tracker/features/medications/models/medication_models.dart';
import 'package:calorie_tracker/features/medications/services/medication_recurrence_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main() {
  setUpAll(tz.initializeTimeZones);
  final fixtures =
      jsonDecode(
            File('test/fixtures/medication-recurrence.json').readAsStringSync(),
          )
          as List;
  for (final f in fixtures) {
    test('shared contract: ${f['name']}', () {
      final rule = f['rule'] as Map;
      final schedule = MedicationScheduleLocal()
        ..clientId = 'revision'
        ..seriesId = 'series'
        ..medicationClientId = 'medication'
        ..frequency = MedicationFrequency.values.byName(
          (f['frequency'] as String).toLowerCase(),
        )
        ..timezone = f['timezone'] as String
        ..startDate = f['startDate'] as String
        ..endDate = f['endDate'] as String?
        ..invalidDatePolicy = f['invalidDatePolicy'] == 'SKIP'
            ? MedicationInvalidDatePolicy.skip
            : MedicationInvalidDatePolicy.lastValidDay
        ..interval = rule['interval'] as int? ?? 1
        ..weekdays = List<int>.from(rule['weekdays'] ?? [])
        ..monthDays = List<int>.from(rule['monthDays'] ?? [])
        ..annualDatesJson = jsonEncode(rule['annualDates'] ?? [])
        ..cycleOnDays = rule['cycleOnDays'] as int?
        ..cycleOffDays = rule['cycleOffDays'] as int?
        ..intervalUnit = rule['intervalUnit'] as String?
        ..slots = (f['slots'] as List)
            .map(
              (time) => MedicationDoseSlotLocal()
                ..clientId = time as String
                ..localTime = time,
            )
            .toList();
      final medication = MedicationLocal()
        ..clientId = 'medication'
        ..displayName = 'Contract fixture';
      final result = const MedicationRecurrenceEngine().expand(
        userId: 'contract-user',
        medication: medication,
        schedule: schedule,
        from: DateTime.parse(f['from']),
        to: DateTime.parse(f['to']),
      );
      expect(
        result
            .map((item) => item.scheduledAt!.toUtc().toIso8601String())
            .toList(),
        f['expected'],
      );
      expect(
        result.map((item) => item.occurrenceKey).toSet().length,
        result.length,
      );
    });
  }
}
