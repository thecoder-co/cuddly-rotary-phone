import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/medication_models.dart';

class MedicationRecurrenceEngine {
  const MedicationRecurrenceEngine();

  List<MedicationOccurrence> expand({
    required String userId,
    required MedicationLocal medication,
    required MedicationScheduleLocal schedule,
    required DateTime from,
    required DateTime to,
    List<MedicationDoseRecordLocal> records = const [],
  }) {
    if (!schedule.active ||
        medication.status != MedicationStatus.active ||
        schedule.frequency == MedicationFrequency.prn)
      return [];
    final location = tz.getLocation(schedule.timezone);
    final start = DateTime.parse('${schedule.startDate}T00:00:00Z');
    final end = schedule.endDate == null
        ? null
        : DateTime.parse('${schedule.endDate!}T00:00:00Z');
    final byKey = {for (final record in records) record.occurrenceKey: record};
    final occurrences = <MedicationOccurrence>[];

    void add(
      DateTime day,
      MedicationDoseSlotLocal slot, {
      tz.TZDateTime? exact,
    }) {
      if (end != null &&
          DateTime.utc(day.year, day.month, day.day).isAfter(end))
        return;
      final time = slot.localTime.split(':').map(int.parse).toList();
      final scheduled =
          exact ??
          tz.TZDateTime(
            location,
            day.year,
            day.month,
            day.day,
            time[0],
            time[1],
          );
      if (scheduled.isBefore(from) || scheduled.isAfter(to)) return;
      if (schedule.effectiveFrom != null &&
          scheduled.isBefore(schedule.effectiveFrom!))
        return;
      if (schedule.effectiveTo != null &&
          !scheduled.isBefore(schedule.effectiveTo!))
        return;
      final local =
          '${scheduled.year.toString().padLeft(4, '0')}-${scheduled.month.toString().padLeft(2, '0')}-${scheduled.day.toString().padLeft(2, '0')}T${scheduled.hour.toString().padLeft(2, '0')}:${scheduled.minute.toString().padLeft(2, '0')}:00';
      final key = _occurrenceKey(
        userId,
        schedule.seriesId ?? schedule.clientId,
        schedule.revision,
        scheduled.toUtc(),
      );
      final record = byKey[key];
      final now = DateTime.now();
      final projected =
          record?.outcome ??
          (scheduled.isAfter(now)
              ? MedicationDoseOutcome.upcoming
              : now.difference(scheduled).inHours >= 24
              ? MedicationDoseOutcome.missed
              : MedicationDoseOutcome.due);
      occurrences.add(
        MedicationOccurrence(
          occurrenceKey: key,
          medication: medication,
          schedule: schedule,
          slot: slot,
          scheduledAt: scheduled,
          scheduledLocal: local,
          outcome: projected,
          record: record,
        ),
      );
    }

    if (schedule.frequency == MedicationFrequency.interval) {
      final slot = schedule.slots.first;
      final anchorText =
          schedule.anchorLocal ?? '${schedule.startDate}T${slot.localTime}:00';
      final anchor = tz.TZDateTime(
        location,
        DateTime.parse(anchorText).year,
        DateTime.parse(anchorText).month,
        DateTime.parse(anchorText).day,
        DateTime.parse(anchorText).hour,
        DateTime.parse(anchorText).minute,
      );
      final duration = switch (schedule.intervalUnit) {
        'DAYS' => Duration(days: schedule.interval),
        'WEEKS' => Duration(days: schedule.interval * 7),
        _ => Duration(hours: schedule.interval),
      };
      var instant = anchor;
      while (instant.isBefore(from)) {
        instant = tz.TZDateTime.from(instant.add(duration), location);
      }
      while (!instant.isAfter(to)) {
        add(instant, slot, exact: instant);
        instant = tz.TZDateTime.from(instant.add(duration), location);
      }
      return occurrences;
    }

    final localFrom = tz.TZDateTime.from(from, location);
    final localTo = tz.TZDateTime.from(to, location);
    var day = DateTime.utc(localFrom.year, localFrom.month, localFrom.day);
    if (day.isBefore(start)) day = start;
    final last = DateTime.utc(localTo.year, localTo.month, localTo.day);
    while (!day.isAfter(last)) {
      if (_qualifies(day, start, schedule))
        for (final slot in schedule.slots) {
          add(day, slot);
        }
      day = day.add(const Duration(days: 1));
    }
    occurrences.sort((a, b) => a.scheduledAt!.compareTo(b.scheduledAt!));
    return occurrences;
  }

  bool _qualifies(
    DateTime day,
    DateTime start,
    MedicationScheduleLocal schedule,
  ) {
    final elapsedDays = DateTime.utc(
      day.year,
      day.month,
      day.day,
    ).difference(DateTime.utc(start.year, start.month, start.day)).inDays;
    if (elapsedDays < 0) return false;
    final interval = schedule.interval < 1 ? 1 : schedule.interval;
    switch (schedule.frequency) {
      case MedicationFrequency.daily:
        return elapsedDays % interval == 0;
      case MedicationFrequency.weekly:
        return (elapsedDays ~/ 7) % interval == 0 &&
            schedule.weekdays.contains(day.weekday);
      case MedicationFrequency.monthly:
        final monthDistance =
            (day.year - start.year) * 12 + day.month - start.month;
        if (monthDistance % interval != 0) return false;
        final maxDay = DateTime(day.year, day.month + 1, 0).day;
        return (schedule.monthDays.isEmpty ? [start.day] : schedule.monthDays)
            .any(
              (requested) => requested <= maxDay
                  ? day.day == requested
                  : schedule.invalidDatePolicy ==
                            MedicationInvalidDatePolicy.lastValidDay &&
                        day.day == maxDay,
            );
      case MedicationFrequency.annual:
        if ((day.year - start.year) % interval != 0) return false;
        final dates = (jsonDecode(schedule.annualDatesJson ?? '[]') as List)
            .cast<Map<String, dynamic>>();
        final requested = dates.isEmpty
            ? [
                {'month': start.month, 'day': start.day},
              ]
            : dates;
        return requested.any((entry) {
          if (entry['month'] == 2 &&
              entry['day'] == 29 &&
              DateTime(day.year, 3, 0).day == 28)
            return schedule.invalidDatePolicy !=
                    MedicationInvalidDatePolicy.skip &&
                day.month == 2 &&
                day.day == 28;
          return day.month == entry['month'] && day.day == entry['day'];
        });
      case MedicationFrequency.cyclical:
        final on = schedule.cycleOnDays ?? 1;
        final off = schedule.cycleOffDays ?? 1;
        return elapsedDays % (on + off) < on;
      case MedicationFrequency.interval:
      case MedicationFrequency.prn:
        return false;
    }
  }

  String _occurrenceKey(
    String userId,
    String seriesId,
    int revision,
    DateTime instant,
  ) =>
      'sha256:${sha256.convert(utf8.encode('$userId|$seriesId|$revision|${instant.toIso8601String()}'))}';
}
