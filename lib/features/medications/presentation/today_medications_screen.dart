import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/medication_models.dart';
import '../providers/medication_provider.dart';
import 'add_medication_flow.dart';
import 'record_dose_sheet.dart';
import 'widgets/medication_ui.dart';
import '../../../core/services/notifications/notification_coordinator.dart';
import '../../../core/services/local_data/local_data.dart';

class TodayMedicationsScreen extends ConsumerStatefulWidget {
  final NotificationPayload? initialPayload;
  const TodayMedicationsScreen({super.key, this.initialPayload});
  @override
  ConsumerState<TodayMedicationsScreen> createState() =>
      _TodayMedicationsScreenState();
}

class _TodayMedicationsScreenState
    extends ConsumerState<TodayMedicationsScreen> {
  DateTime date = DateTime.now();
  bool handledPayload = false;
  bool followingToday = true;
  Timer? refreshTimer;
  @override
  void initState() {
    super.initState();
    refreshTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted)
        setState(() {
          if (followingToday) date = DateTime.now();
        });
    });
  }

  @override
  void dispose() {
    refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(todayMedicationProvider(date));
    data.whenData((items) {
      if (!handledPayload && widget.initialPayload != null) {
        final matches = items.where(
          (item) => item.occurrenceKey == widget.initialPayload!.occurrenceKey,
        );
        if (matches.isNotEmpty) {
          handledPayload = true;
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            final action = widget.initialPayload!.action;
            if (action == 'TAKEN')
              await ref
                  .read(medicationActionsProvider)
                  .record(matches.first, MedicationDoseOutcome.taken);
            else if (action == 'SKIPPED')
              await ref
                  .read(medicationActionsProvider)
                  .record(matches.first, MedicationDoseOutcome.skipped);
            else if (action == 'SNOOZED')
              await ref
                  .read(medicationActionsProvider)
                  .record(
                    matches.first,
                    MedicationDoseOutcome.snoozed,
                    snoozedUntil: DateTime.now().add(
                      Duration(
                        minutes:
                            LocalData.prefs.getInt('medication_snooze') ?? 15,
                      ),
                    ),
                  );
            else if (mounted)
              showRecordDoseSheet(context, matches.first);
          });
        }
      }
    });
    return MedicationPageScaffold(
      backgroundColor: medicationPageColor(context),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: MedicationHeader(
                title: 'Today',
                eyebrow: DateFormat('EEEE, MMMM d').format(date).toUpperCase(),
                actions: [
                  MedicationRoundButton(
                    icon: CupertinoIcons.calendar,
                    label: 'Choose date',
                    onPressed: _pickDate,
                  ),
                  MedicationRoundButton(
                    icon: CupertinoIcons.add,
                    label: 'Add medication',
                    filled: true,
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).push(
                          CupertinoPageRoute(
                            builder: (_) => const AddMedicationFlow(),
                          ),
                        ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
              sliver: SliverToBoxAdapter(
                child: data.when(
                  loading: () => Center(child: CupertinoActivityIndicator()),
                  error: (error, _) => _MessageCard(
                    icon: CupertinoIcons.exclamationmark_triangle,
                    title: 'Could not load today’s doses',
                    message: error.toString(),
                  ),
                  data: (items) => _TodayBody(date: date, items: items),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (selected != null)
      setState(() {
        date = selected;
        followingToday = DateUtils.isSameDay(selected, DateTime.now());
      });
  }
}

class _TodayBody extends ConsumerWidget {
  final DateTime date;
  final List<MedicationOccurrence> items;
  const _TodayBody({required this.date, required this.items});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taken = items
        .where((e) => e.outcome == MedicationDoseOutcome.taken)
        .length;
    final unresolved = items
        .where(
          (e) =>
              e.outcome == MedicationDoseOutcome.due ||
              e.outcome == MedicationDoseOutcome.snoozed,
        )
        .toList();
    final next = unresolved.isNotEmpty
        ? unresolved.first
        : items
              .where((e) => e.outcome == MedicationDoseOutcome.upcoming)
              .firstOrNull;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MedicationSurface(
          radius: 20,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Taken $taken of ${items.length} today',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: items.isEmpty ? 0 : taken / items.length,
                        minHeight: 7,
                        color: CupertinoDynamicColor.resolve(
                          medicationGreen,
                          context,
                        ),
                        backgroundColor: medicationGreen.withOpacity(.12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                items.isEmpty
                    ? '—'
                    : '${((taken / items.length) * 100).round()}%',
                style: TextStyle(
                  color: CupertinoDynamicColor.resolve(
                    medicationGreen,
                    context,
                  ),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        if (next != null) ...[
          const SizedBox(height: 20),
          const _SectionLabel('NEXT DOSE'),
          _OccurrenceCard(occurrence: next, hero: true),
        ],
        if (items.isEmpty) ...[
          const SizedBox(height: 20),
          const _MessageCard(
            icon: CupertinoIcons.capsule,
            title: 'No doses scheduled',
            message:
                'Add a medication or record an as-needed dose when you need it.',
          ),
        ],
        ..._sections(items).entries.expand(
          (entry) => [
            const SizedBox(height: 20),
            _SectionLabel(entry.key),
            ...entry.value.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _OccurrenceCard(occurrence: item),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        CupertinoButton(
          color: medicationCardColor(context),
          padding: const EdgeInsets.symmetric(vertical: 14),
          onPressed: () async {
            final repo = ref.read(localMedicationRepoProvider);
            final choices = <MedicationOccurrence>[];
            for (final medication in await repo.getActiveMedications()) {
              if (medication.status != MedicationStatus.active) continue;
              final schedules = await repo.schedulesFor(medication.clientId);
              final schedule = schedules.firstOrNull;
              if (schedule == null ||
                  schedule.frequency != MedicationFrequency.prn ||
                  schedule.slots.isEmpty)
                continue;
              choices.add(
                MedicationOccurrence(
                  occurrenceKey: 'prn:${const Uuid().v4()}',
                  medication: medication,
                  schedule: schedule,
                  slot: schedule.slots.first,
                  scheduledAt: null,
                  scheduledLocal: DateTime.now().toIso8601String(),
                  outcome: MedicationDoseOutcome.due,
                ),
              );
            }
            if (!context.mounted) return;
            if (choices.isEmpty) {
              await showCupertinoDialog<void>(
                context: context,
                builder: (dialogContext) => CupertinoAlertDialog(
                  title: Text('No as-needed medications'),
                  content: Text(
                    'Add a medication with an As-needed schedule to record a dose here.',
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
              return;
            }
            final choice = await showCupertinoModalPopup<MedicationOccurrence>(
              context: context,
              builder: (sheetContext) => CupertinoActionSheet(
                title: Text('Log as-needed dose'),
                actions: [
                  for (final option in choices)
                    CupertinoActionSheetAction(
                      onPressed: () => Navigator.pop(sheetContext, option),
                      child: Text(option.medication.displayName),
                    ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: Text('Cancel'),
                ),
              ),
            );
            if (choice != null && context.mounted)
              await showRecordDoseSheet(context, choice);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.add_circled, color: medicationGreen),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Log as-needed dose',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CupertinoDynamicColor.resolve(
                      medicationGreen,
                      context,
                    ),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Map<String, List<MedicationOccurrence>> _sections(
    List<MedicationOccurrence> values,
  ) {
    final result = <String, List<MedicationOccurrence>>{};
    for (final item in values) {
      if (item ==
          (values
                  .where(
                    (e) =>
                        e.outcome == MedicationDoseOutcome.due ||
                        e.outcome == MedicationDoseOutcome.snoozed,
                  )
                  .firstOrNull ??
              values
                  .where((e) => e.outcome == MedicationDoseOutcome.upcoming)
                  .firstOrNull))
        continue;
      final label = switch (item.outcome) {
        MedicationDoseOutcome.due => 'DUE & OVERDUE',
        MedicationDoseOutcome.snoozed => 'SNOOZED',
        MedicationDoseOutcome.taken => 'TAKEN TODAY',
        MedicationDoseOutcome.skipped => 'SKIPPED',
        MedicationDoseOutcome.missed => 'MISSED',
        _ => 'UPCOMING',
      };
      result.putIfAbsent(label, () => []).add(item);
    }
    return result;
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: .4,
        color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(.55),
      ),
    ),
  );
}

class _MessageCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  const _MessageCard({
    required this.icon,
    required this.title,
    required this.message,
  });
  @override
  Widget build(BuildContext context) => MedicationSurface(
    child: Column(
      children: [
        Icon(
          icon,
          color: CupertinoDynamicColor.resolve(medicationTeal, context),
          size: 34,
        ),
        const SizedBox(height: 10),
        Text(title, style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 5),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: Theme.of(
              context,
            ).textTheme.bodySmall?.color?.withOpacity(.65),
          ),
        ),
      ],
    ),
  );
}

class _OccurrenceCard extends StatelessWidget {
  final MedicationOccurrence occurrence;
  final bool hero;
  const _OccurrenceCard({required this.occurrence, this.hero = false});
  @override
  Widget build(BuildContext context) => MedicationSurface(
    radius: hero ? 20 : 16,
    borderColor: hero ? medicationDue.withOpacity(.45) : null,
    onTap: () => showRecordDoseSheet(context, occurrence),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MedicationAvatar(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          occurrence.medication.displayName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      MedicationStatusPill(occurrence.outcome),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${occurrence.medication.strengthLabel.isEmpty ? '' : '${occurrence.medication.strengthLabel} • '}${occurrence.slot.doseQuantity.g} ${occurrence.slot.doseUnit}',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${DateFormat.jm().format(occurrence.scheduledAt!)}${occurrence.slot.instructions == null ? '' : ' • ${occurrence.slot.instructions}'}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(
                        context,
                      ).textTheme.bodySmall?.color?.withOpacity(.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if ({
          MedicationDoseOutcome.due,
          MedicationDoseOutcome.snoozed,
          MedicationDoseOutcome.upcoming,
        }.contains(occurrence.outcome)) ...[
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: const Color(0xFF17621A),
              padding: const EdgeInsets.symmetric(vertical: 11),
              onPressed: () => showRecordDoseSheet(context, occurrence),
              child: Text(
                occurrence.outcome == MedicationDoseOutcome.upcoming
                    ? 'Record dose'
                    : '✓  Record Dose',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

extension _DoseFormat on double {
  String get g => this == roundToDouble() ? toInt().toString() : toString();
}
