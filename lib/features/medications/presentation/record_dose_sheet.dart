import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/services/local_data/local_data.dart';
import '../models/medication_models.dart';
import '../providers/medication_provider.dart';
import 'widgets/medication_ui.dart';

Future<void> showRecordDoseSheet(
  BuildContext context,
  MedicationOccurrence occurrence,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useRootNavigator: true,
  backgroundColor: Colors.transparent,
  builder: (_) => RecordDoseSheet(occurrence: occurrence),
);

class RecordDoseSheet extends ConsumerStatefulWidget {
  final MedicationOccurrence occurrence;
  const RecordDoseSheet({super.key, required this.occurrence});
  @override
  ConsumerState<RecordDoseSheet> createState() => _RecordDoseSheetState();
}

class _RecordDoseSheetState extends ConsumerState<RecordDoseSheet> {
  final note = TextEditingController();
  bool saving = false;
  @override
  void initState() {
    super.initState();
    note.text = widget.occurrence.record?.note ?? '';
  }

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  Future<void> _record(
    MedicationDoseOutcome outcome, {
    DateTime? at,
    DateTime? snoozedUntil,
  }) async {
    setState(() => saving = true);
    try {
      await ref
          .read(medicationActionsProvider)
          .record(
            widget.occurrence,
            outcome,
            actedAt: at,
            snoozedUntil: snoozedUntil,
            note: note.text.trim().isEmpty ? null : note.text.trim(),
          );
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (!mounted) return;
      setState(() => saving = false);
      await showCupertinoDialog<void>(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text('Dose was not saved'),
          content: Text(
            'Please try again. Your existing record has not been discarded.',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final o = widget.occurrence;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          20,
          10,
          20,
          20 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        decoration: BoxDecoration(
          color: dark ? const Color(0xFF121212) : const Color(0xFFF2F2F7),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.4),
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  Expanded(
                    child: Text(
                      'Record Dose',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 54),
                ],
              ),
              const SizedBox(height: 14),
              MedicationSurface(
                child: Row(
                  children: [
                    const MedicationAvatar(size: 52),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            o.medication.displayName,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${o.medication.strengthLabel.isEmpty ? '' : '${o.medication.strengthLabel} • '}Dose: ${o.slot.doseQuantity.g} ${o.slot.doseUnit}',
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            o.scheduledAt == null
                                ? 'As-needed dose · No scheduled time'
                                : 'Scheduled ${DateFormat.jm().format(o.scheduledAt!)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: CupertinoDynamicColor.resolve(
                                medicationDue,
                                context,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (o.slot.instructions?.isNotEmpty == true)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: MedicationSurface(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.info_circle,
                          size: 16,
                          color: CupertinoDynamicColor.resolve(
                            medicationTeal,
                            context,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            o.slot.instructions!,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: const Color(0xFF17621A),
                  onPressed: saving
                      ? null
                      : () => _record(MedicationDoseOutcome.taken),
                  child: Text(
                    saving
                        ? 'Saving…'
                        : '✓  Taken now (${DateFormat.jm().format(DateTime.now())})',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              MedicationSurface(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'I took it at…',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: saving ? null : _chooseTime,
                          child: Text(
                            'Custom time',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        for (final minutes in [10, 30, 60])
                          Expanded(
                            child: CupertinoButton(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              onPressed: saving
                                  ? null
                                  : () => _record(
                                      MedicationDoseOutcome.taken,
                                      at: DateTime.now().subtract(
                                        Duration(minutes: minutes),
                                      ),
                                    ),
                              child: Text(
                                DateFormat.jm().format(
                                  DateTime.now().subtract(
                                    Duration(minutes: minutes),
                                  ),
                                ),
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              if (o.scheduledAt != null)
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        icon: CupertinoIcons.clock,
                        label:
                            'Snooze ${LocalData.prefs.getInt('medication_snooze') ?? 15}m',
                        onTap: () {
                          if (saving) return;
                          _record(
                            MedicationDoseOutcome.snoozed,
                            snoozedUntil: DateTime.now().add(
                              Duration(
                                minutes:
                                    LocalData.prefs.getInt(
                                      'medication_snooze',
                                    ) ??
                                    15,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ActionButton(
                        icon: CupertinoIcons.forward,
                        label: 'Skip dose',
                        onTap: () {
                          if (!saving) _record(MedicationDoseOutcome.skipped);
                        },
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              CupertinoTextField(
                controller: note,
                placeholder: 'Add note (e.g. took with light snack)',
                minLines: 1,
                maxLines: 3,
                padding: const EdgeInsets.all(14),
              ),
              if (o.scheduledAt != null &&
                  DateTime.now().difference(o.scheduledAt!).inHours >= 1) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: medicationDue.withOpacity(.12),
                    border: Border.all(color: medicationDue.withOpacity(.6)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.lightbulb_fill,
                        color: CupertinoDynamicColor.resolve(
                          medicationDue,
                          context,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Recording a late dose? Your next dose remains scheduled unless you edit the regimen.',
                          style: TextStyle(
                            fontSize: 12,
                            color: dark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Text(
                'Qarr Track records your doses and does not provide medical or dosage recommendations.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(
                    context,
                  ).textTheme.bodySmall?.color?.withOpacity(.55),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _chooseTime() async {
    final value = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (value == null) return;
    final now = widget.occurrence.scheduledAt ?? DateTime.now();
    final at = DateTime(now.year, now.month, now.day, value.hour, value.minute);
    if (at.isAfter(DateTime.now())) return;
    await _record(MedicationDoseOutcome.taken, at: at);
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => CupertinoButton(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
    color: medicationCardColor(context),
    onPressed: onTap,
    child: Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    ),
  );
}

extension _DoseFormat on double {
  String get g => this == roundToDouble() ? toInt().toString() : toString();
}
