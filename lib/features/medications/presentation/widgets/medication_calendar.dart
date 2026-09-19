import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/medication_models.dart';
import 'medication_ui.dart';

class MedicationCalendar extends StatelessWidget {
  final DateTime selected;
  final List<MedicationDoseRecordLocal> records;
  final ValueChanged<DateTime> onSelected;
  const MedicationCalendar({
    super.key,
    required this.selected,
    required this.records,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final first = DateTime(selected.year, selected.month);
    final count = DateTime(selected.year, selected.month + 1, 0).day;
    final offset = first.weekday - 1;
    final cells = ((offset + count) / 7).ceil() * 7;
    final accent = CupertinoDynamicColor.resolve(medicationGreen, context);
    return MedicationSurface(
      child: Column(
        children: [
          Row(
            children: [
              for (final day in ['M', 'T', 'W', 'T', 'F', 'S', 'S'])
                Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(
                        fontSize: 11,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          for (var week = 0; week < cells ~/ 7; week++)
            Row(
              children: [
                for (var weekday = 0; weekday < 7; weekday++)
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final day = first.add(
                          Duration(days: week * 7 + weekday - offset),
                        );
                        final currentMonth = day.month == selected.month;
                        final active = day.day == selected.day && currentMonth;
                        final dayRecords = records.where((record) {
                          final date = (record.scheduledAt ?? record.recordedAt)
                              .toLocal();
                          return date.year == day.year &&
                              date.month == day.month &&
                              date.day == day.day;
                        });
                        final colors = dayRecords
                            .map(
                              (record) => record.scheduledAt == null
                                  ? medicationSnoozed
                                  : switch (record.outcome) {
                                      MedicationDoseOutcome.taken =>
                                        record.takenAt != null &&
                                                record.takenAt!
                                                        .difference(
                                                          record.scheduledAt!,
                                                        )
                                                        .inMinutes >
                                                    30
                                            ? medicationDue
                                            : medicationGreen,
                                      MedicationDoseOutcome.missed =>
                                        medicationMissed,
                                      _ => medicationSkipped,
                                    },
                            )
                            .toSet()
                            .take(3);
                        return Semantics(
                          label:
                              '${day.year}-${day.month}-${day.day}, ${dayRecords.length} recorded doses',
                          selected: active,
                          button: true,
                          child: GestureDetector(
                            onTap: () => onSelected(day),
                            child: Container(
                              height: 48,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: active ? const Color(0xFF17621A) : null,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${day.day}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: active
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                      color: active
                                          ? Colors.white
                                          : currentMonth
                                          ? Theme.of(
                                              context,
                                            ).textTheme.bodyLarge?.color
                                          : CupertinoColors.systemGrey3,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (final color in colors)
                                        Container(
                                          width: 4,
                                          height: 4,
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 1,
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: active
                                                ? Colors.white
                                                : CupertinoDynamicColor.resolve(
                                                    color,
                                                    context,
                                                  ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          const Divider(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              for (final entry in {
                'Taken': accent,
                'Late': CupertinoDynamicColor.resolve(medicationDue, context),
                'Skipped': medicationSkipped,
                'Missed': medicationMissed,
                'PRN': CupertinoDynamicColor.resolve(
                  medicationSnoozed,
                  context,
                ),
              }.entries)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: entry.value,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(entry.key, style: const TextStyle(fontSize: 10)),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
