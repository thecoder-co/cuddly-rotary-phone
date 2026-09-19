import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../models/medication_models.dart';
import '../providers/medication_provider.dart';
import '../services/medication_report_service.dart';
import 'widgets/medication_ui.dart';
import 'widgets/medication_calendar.dart';
import 'record_dose_sheet.dart';

class MedicationHistoryScreen extends ConsumerStatefulWidget {
  const MedicationHistoryScreen({super.key});
  @override
  ConsumerState<MedicationHistoryScreen> createState() =>
      _MedicationHistoryScreenState();
}

class _MedicationHistoryScreenState
    extends ConsumerState<MedicationHistoryScreen> {
  DateTime selected = DateTime.now();
  bool calendar = true;
  DateTimeRange? reportRange;
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(medicationHistoryProvider);
    return MedicationPageScaffold(
      backgroundColor: medicationPageColor(context),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: MedicationHeader(
                title: 'History',
                eyebrow: 'PAST DOSAGES & LOGS',
                actions: [
                  MedicationRoundButton(
                    icon: CupertinoIcons.share,
                    label: 'Export medication report',
                    onPressed: _exportInfo,
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
              sliver: SliverToBoxAdapter(
                child: data.when(
                  loading: () => const CupertinoActivityIndicator(),
                  error: (e, _) => Text('$e'),
                  data: (records) => _body(context, records),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context, List<MedicationDoseRecordLocal> records) {
    final monthRecords = records.where((record) {
      final date = (record.scheduledAt ?? record.recordedAt).toLocal();
      return date.year == selected.year && date.month == selected.month;
    }).toList();
    final scheduled = monthRecords
        .where(
          (r) =>
              r.scheduledAt != null &&
              r.outcome != MedicationDoseOutcome.snoozed,
        )
        .toList();
    final taken = scheduled
        .where((r) => r.outcome == MedicationDoseOutcome.taken)
        .length;
    final expected = scheduled.length;
    final percent = expected == 0 ? null : taken / expected;
    final dayRecords = records.where((r) {
      final d = (r.scheduledAt ?? r.recordedAt).toLocal();
      return d.year == selected.year &&
          d.month == selected.month &&
          d.day == selected.day;
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => setState(
                () => selected = DateTime(selected.year, selected.month - 1),
              ),
              child: Icon(CupertinoIcons.chevron_left, size: 18),
            ),
            Expanded(
              child: Text(
                DateFormat.yMMMM().format(selected),
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => setState(
                () => selected = DateTime(selected.year, selected.month + 1),
              ),
              child: Icon(CupertinoIcons.chevron_right, size: 18),
            ),
            CupertinoButton(
              padding: const EdgeInsets.only(left: 12),
              onPressed: () => setState(() => calendar = !calendar),
              child: Icon(
                calendar ? CupertinoIcons.list_bullet : CupertinoIcons.calendar,
                size: 20,
              ),
            ),
          ],
        ),
        if (calendar)
          MedicationCalendar(
            selected: selected,
            records: records,
            onSelected: (date) => setState(() => selected = date),
          ),
        const SizedBox(height: 16),
        MedicationSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'My Logged Adherence',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    percent == null ? '—' : '${(percent * 100).round()}%',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: CupertinoDynamicColor.resolve(
                        medicationGreen,
                        context,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LinearProgressIndicator(
                  value: percent ?? 0,
                  color: const Color(0xFF17621A),
                  backgroundColor: medicationSkipped.withOpacity(.15),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '$taken of $expected recorded scheduled outcomes marked Taken this month. As-needed and unrecorded doses are excluded.',
                style: TextStyle(
                  fontSize: 11,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  for (final outcome in [
                    MedicationDoseOutcome.taken,
                    MedicationDoseOutcome.skipped,
                    MedicationDoseOutcome.missed,
                  ])
                    Expanded(
                      child: _Metric(
                        value:
                            '${scheduled.where((r) => r.outcome == outcome).length}',
                        label: outcome.name.toUpperCase(),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Text(
                calendar
                    ? 'DOSE LOG · ${DateFormat.MMMEd().format(selected)}'
                    : 'ALL DOSES',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${(calendar ? dayRecords : records).length} recorded',
              style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if ((calendar ? dayRecords : records).isEmpty)
          const MedicationSurface(
            child: Center(child: Text('No dose history for this date.')),
          )
        else
          for (final record in (calendar ? dayRecords : records))
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _HistoryRow(record),
            ),
      ],
    );
  }

  void _exportInfo() => showCupertinoModalPopup(
    context: context,
    builder: (_) => CupertinoActionSheet(
      title: Text('Export medication report'),
      message: Text(
        'Reports are saved privately on this device. The selected calendar month is used unless you choose another range.',
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
            final range = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
              initialDateRange: reportRange,
            );
            if (range != null && mounted) {
              setState(() => reportRange = range);
              _exportInfo();
            }
          },
          child: Text('Choose date range'),
        ),
        CupertinoActionSheetAction(
          onPressed: () => _generateReport(pdf: true),
          child: Text('PDF report'),
        ),
        CupertinoActionSheetAction(
          onPressed: () => _generateReport(pdf: false),
          child: Text('CSV data'),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        child: Text('Cancel'),
      ),
    ),
  );

  Future<void> _generateReport({required bool pdf}) async {
    Navigator.of(context, rootNavigator: true).pop();
    final allRecords =
        ref.read(medicationHistoryProvider).value ??
        const <MedicationDoseRecordLocal>[];
    final from = reportRange?.start ?? DateTime(selected.year, selected.month);
    final to = reportRange == null
        ? DateTime(selected.year, selected.month + 1)
        : reportRange!.end.add(const Duration(days: 1));
    final records = allRecords.where((record) {
      final date = record.scheduledAt ?? record.recordedAt;
      return !date.isBefore(from) && date.isBefore(to);
    }).toList();
    final names = <String, String>{};
    for (final id
        in records.map((record) => record.medicationClientId).toSet()) {
      names[id] =
          (await ref.read(localMedicationRepoProvider).getMedication(id))
              ?.displayName ??
          'Archived medication';
    }
    final service = const MedicationReportService();
    final file = pdf
        ? await service.exportPdf(records, medicationNames: names)
        : await service.exportCsv(records, medicationNames: names);
    if (!mounted) return;
    await showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text('Report created'),
        content: Text(
          'Saved privately on this device. Only share this health information with people you trust.',
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              final box = context.findRenderObject() as RenderBox?;
              await SharePlus.instance.share(
                ShareParams(
                  files: [XFile(file.path)],
                  sharePositionOrigin: box == null
                      ? null
                      : box.localToGlobal(Offset.zero) & box.size,
                ),
              );
            },
            child: Text('Share report'),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String value, label;
  const _Metric({required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: CupertinoDynamicColor.resolve(medicationGreen, context),
        ),
      ),
      const SizedBox(height: 3),
      Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 11)),
    ],
  );
}

class _HistoryRow extends ConsumerWidget {
  final MedicationDoseRecordLocal record;
  const _HistoryRow(this.record);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medication = ref
        .watch(medicationByIdProvider(record.medicationClientId))
        .value;
    return MedicationSurface(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MedicationStatusPill(record.outcome),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  record.scheduledAt == null
                      ? 'As needed'
                      : 'Scheduled ${DateFormat.jm().format(record.scheduledAt!.toLocal())}',
                  style: TextStyle(
                    fontSize: 11,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                onPressed: medication == null
                    ? null
                    : () async {
                        final schedule = record.scheduleClientId == null
                            ? null
                            : await ref
                                  .read(localMedicationRepoProvider)
                                  .getSchedule(record.scheduleClientId!);
                        if (!context.mounted) return;
                        await showRecordDoseSheet(
                          context,
                          MedicationOccurrence(
                            occurrenceKey: record.occurrenceKey,
                            medication: medication,
                            schedule: schedule,
                            slot: MedicationDoseSlotLocal()
                              ..clientId = record.occurrenceKey
                              ..localTime = record.scheduledAt == null
                                  ? '00:00'
                                  : DateFormat(
                                      'HH:mm',
                                    ).format(record.scheduledAt!)
                              ..doseQuantity = record.doseQuantity
                              ..doseUnit = record.doseUnit
                              ..instructions = record.instructions,
                            scheduledAt: record.scheduledAt,
                            scheduledLocal: record.scheduledLocal ?? '',
                            outcome: record.outcome,
                            record: record,
                          ),
                        );
                      },
                child: Text('Edit', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            medication?.displayName ?? 'Medication',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(
            '${record.doseQuantity.g} ${record.doseUnit} · Recorded ${DateFormat.jm().format((record.takenAt ?? record.recordedAt).toLocal())}',
            style: TextStyle(fontSize: 12),
          ),
          if (record.note?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Note: ${record.note}',
                style: TextStyle(
                  fontSize: 11,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ),
          if (record.corrected)
            Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                'Corrected · Previous action retained in audit history',
                style: TextStyle(
                  fontSize: 10,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

extension _DoseFormat on double {
  String get g => this == roundToDouble() ? toInt().toString() : toString();
}
