import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/medication_models.dart';
import '../providers/medication_provider.dart';
import 'widgets/medication_ui.dart';
import 'add_medication_flow.dart';
import 'record_dose_sheet.dart';

class MedicationDetailScreen extends ConsumerWidget {
  final String clientId;
  const MedicationDetailScreen({super.key, required this.clientId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medication = ref.watch(medicationByIdProvider(clientId));
    return MedicationPageScaffold(
      backgroundColor: medicationPageColor(context),
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Medication Details'),
      ),
      child: SafeArea(
        child: medication.when(
          loading: () => Center(child: CupertinoActivityIndicator()),
          error: (e, _) => Center(child: Text('$e')),
          data: (m) => m == null
              ? Center(child: Text('Medication not found'))
              : ListView(
                  padding: const EdgeInsets.all(20),
                  children: [MedicationDetailCard(m)],
                ),
        ),
      ),
    );
  }
}

class MedicationDetailCard extends ConsumerWidget {
  final MedicationLocal medication;
  final bool embedded;
  const MedicationDetailCard(
    this.medication, {
    super.key,
    this.embedded = false,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(medicationByIdProvider(medication.clientId));
    final accent = CupertinoDynamicColor.resolve(medicationGreen, context);
    return MedicationSurface(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    medication.status.name.toUpperCase(),
                    style: TextStyle(
                      color: accent,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medication.displayName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${medication.strengthLabel.isEmpty ? '' : '${medication.strengthLabel} · '}${medication.form ?? 'dose'} · ${medication.route ?? 'Not specified'}',
                            style: TextStyle(
                              fontSize: 13,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const MedicationAvatar(),
                  ],
                ),
                const SizedBox(height: 14),
                FutureBuilder<List<MedicationScheduleLocal>>(
                  future: ref
                      .read(localMedicationRepoProvider)
                      .schedulesFor(medication.clientId),
                  builder: (_, snapshot) {
                    final schedule = snapshot.data?.firstOrNull;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: medicationPageColor(context),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                CupertinoIcons.clock,
                                size: 16,
                                color: CupertinoColors.systemGrey,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  schedule == null
                                      ? 'No schedule'
                                      : 'Schedule: ${schedule.frequency.name.toUpperCase()} · ${schedule.slots.map((s) => '${s.doseQuantity} ${s.doseUnit}${schedule.frequency == MedicationFrequency.prn ? '' : ' at ${s.localTime}'}').join(', ')}\n${medication.instructions ?? ''}',
                                  style: TextStyle(fontSize: 12, height: 1.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (schedule?.frequency == MedicationFrequency.prn &&
                            medication.status == MedicationStatus.active)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CupertinoButton.filled(
                              onPressed: () => showRecordDoseSheet(
                                context,
                                MedicationOccurrence(
                                  occurrenceKey: 'prn:${const Uuid().v4()}',
                                  medication: medication,
                                  schedule: schedule,
                                  slot: schedule!.slots.first,
                                  scheduledAt: null,
                                  scheduledLocal: DateTime.now()
                                      .toIso8601String(),
                                  outcome: MedicationDoseOutcome.due,
                                ),
                              ),
                              child: Text('Record as-needed dose'),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                if (medication.prescriber?.isNotEmpty == true ||
                    medication.pharmacy?.isNotEmpty == true) ...[
                  const Divider(height: 26),
                  if (medication.prescriber?.isNotEmpty == true)
                    Text(
                      'Prescriber   ${medication.prescriber}',
                      style: TextStyle(fontSize: 12),
                    ),
                  if (medication.pharmacy?.isNotEmpty == true)
                    Text(
                      'Pharmacy    ${medication.pharmacy}',
                      style: TextStyle(fontSize: 12),
                    ),
                ],
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(18),
            child: FutureBuilder<MedicationSupplyLocal?>(
              future: ref
                  .read(localMedicationRepoProvider)
                  .supplyFor(medication.clientId),
              builder: (_, snapshot) {
                final supply = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.cube_box,
                          size: 14,
                          color: CupertinoDynamicColor.resolve(
                            medicationDue,
                            context,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'CURRENT INVENTORY',
                            style: TextStyle(
                              fontSize: 11,
                              letterSpacing: .5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (supply?.refillThreshold != null)
                          Text(
                            'Threshold: ${supply!.refillThreshold!.toStringAsFixed(0)} left',
                            style: TextStyle(
                              fontSize: 10,
                              color: CupertinoDynamicColor.resolve(
                                medicationDue,
                                context,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      supply == null
                          ? 'Supply tracking is off'
                          : '${supply.quantity.toStringAsFixed(supply.quantity % 1 == 0 ? 0 : 1)} ${supply.unit} remaining',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (supply != null) ...[
                      const SizedBox(height: 12),
                      if (supply.refillThreshold != null &&
                          supply.quantity <= supply.refillThreshold!)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Stock is at or below your refill threshold.',
                            style: TextStyle(
                              fontSize: 11,
                              color: CupertinoDynamicColor.resolve(
                                medicationDue,
                                context,
                              ),
                            ),
                          ),
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: CupertinoButton(
                              color: const Color(0xFF17621A),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              onPressed: () =>
                                  _changeSupply(context, ref, refill: true),
                              child: Text(
                                'Record Refill',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CupertinoButton(
                              color: medicationPageColor(context),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              onPressed: () =>
                                  _changeSupply(context, ref, refill: false),
                              child: Text(
                                'Adjust Stock',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CONSISTENCY LOG',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '${(ref.watch(medicationHistoryProvider).value ?? []).where((r) => r.medicationClientId == medication.clientId).length} dose records. See History for recorded times, notes and corrections.',
                  style: TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ],
            ),
          ),
          _managementRow(context, 'Edit Regimen & Reminders', () async {
            final schedules = await ref
                .read(localMedicationRepoProvider)
                .schedulesFor(medication.clientId);
            if (!context.mounted) return;
            await Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute(
                builder: (_) => AddMedicationFlow(
                  medication: medication,
                  schedule: schedules.firstOrNull,
                ),
              ),
            );
            ref.invalidate(medicationByIdProvider(medication.clientId));
          }),
          _managementRow(
            context,
            switch (medication.status) {
              MedicationStatus.active => 'Pause Reminders',
              MedicationStatus.paused => 'Resume Medication',
              MedicationStatus.archived => 'Restore Medication',
            },
            () => ref
                .read(medicationActionsProvider)
                .setStatus(
                  medication,
                  medication.status == MedicationStatus.active
                      ? MedicationStatus.paused
                      : MedicationStatus.active,
                ),
          ),
          if (medication.status != MedicationStatus.archived)
            _managementRow(
              context,
              'Archive Medication',
              () => _archive(context, ref),
            ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Archive preserves past dose logs. Permanent deletion is available in Medication Settings.',
              style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _managementRow(
    BuildContext context,
    String label,
    VoidCallback onTap,
  ) => Column(
    children: [
      const Divider(height: 1),
      CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        onPressed: onTap,
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              color: CupertinoColors.systemGrey,
              size: 14,
            ),
          ],
        ),
      ),
    ],
  );
  Future<void> _archive(BuildContext context, WidgetRef ref) async {
    final confirmed = await showCupertinoDialog<bool>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text('Archive medication?'),
        content: Text('Future reminders stop, but dose history is preserved.'),
        actions: [
          CupertinoDialogAction(
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(false),
            child: Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(true),
            child: Text('Archive'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref
          .read(medicationActionsProvider)
          .setStatus(medication, MedicationStatus.archived);
      if (context.mounted && !embedded) Navigator.pop(context);
    }
  }

  Future<void> _changeSupply(
    BuildContext context,
    WidgetRef ref, {
    required bool refill,
  }) async {
    final amount = TextEditingController();
    final reason = TextEditingController();
    final result = await showCupertinoDialog<(double, String)?>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: Text(refill ? 'Add a refill' : 'Adjust stock'),
        content: Column(
          children: [
            const SizedBox(height: 12),
            CupertinoTextField(
              controller: amount,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              placeholder: refill ? 'Quantity added' : 'Change, e.g. -2 or 5',
            ),
            const SizedBox(height: 8),
            CupertinoTextField(
              controller: reason,
              placeholder: refill ? 'Note (optional)' : 'Reason',
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              final value = double.tryParse(amount.text.trim());
              final valid =
                  value != null &&
                  value != 0 &&
                  (!refill || value > 0) &&
                  (refill || reason.text.trim().isNotEmpty);
              if (valid) {
                Navigator.pop(dialogContext, (value, reason.text.trim()));
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
    amount.dispose();
    reason.dispose();
    if (result == null) return;
    await ref
        .read(medicationActionsProvider)
        .adjustSupply(
          medication,
          delta: result.$1,
          refill: refill,
          reason: result.$2.isEmpty ? null : result.$2,
        );
    ref.invalidate(medicationByIdProvider(medication.clientId));
  }
}
