import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medication_models.dart';
import '../providers/medication_provider.dart';
import 'add_medication_flow.dart';
import 'medication_detail_screen.dart';
import 'medication_settings_screen.dart';
import 'widgets/medication_ui.dart';

class MedicationsListScreen extends ConsumerStatefulWidget {
  const MedicationsListScreen({super.key});
  @override
  ConsumerState<MedicationsListScreen> createState() =>
      _MedicationsListScreenState();
}

class _MedicationsListScreenState extends ConsumerState<MedicationsListScreen> {
  String query = '';
  String filter = 'Active';
  String? focusedId;
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(medicationsProvider);
    return MedicationPageScaffold(
      backgroundColor: medicationPageColor(context),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: MedicationHeader(
                title: 'Medications',
                actions: [
                  MedicationRoundButton(
                    icon: CupertinoIcons.gear,
                    label: 'Medication settings',
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).push(
                          CupertinoPageRoute(
                            builder: (_) => const MedicationSettingsScreen(),
                          ),
                        ),
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
                child: Column(
                  children: [
                    CupertinoSearchTextField(
                      placeholder: 'Search active, paused or archived',
                      onChanged: (value) =>
                          setState(() => query = value.toLowerCase()),
                    ),
                    const SizedBox(height: 16),
                    data.when(
                      loading: () => const CupertinoActivityIndicator(),
                      error: (e, _) => Text('Could not load medications: $e'),
                      data: (items) => FutureBuilder<List<MedicationSupplyLocal?>>(
                        future: Future.wait(
                          items.map(
                            (m) => ref
                                .read(localMedicationRepoProvider)
                                .supplyFor(m.clientId),
                          ),
                        ),
                        builder: (_, snapshot) {
                          final stocks = snapshot.data ?? [];
                          final lowIds = {
                            for (
                              var i = 0;
                              i < stocks.length && i < items.length;
                              i++
                            )
                              if (stocks[i] != null &&
                                  stocks[i]!.refillThreshold != null &&
                                  stocks[i]!.quantity <=
                                      stocks[i]!.refillThreshold!)
                                items[i].clientId,
                          };
                          final filtered = items
                              .where(
                                (m) =>
                                    m.displayName.toLowerCase().contains(
                                      query,
                                    ) &&
                                    switch (filter) {
                                      'Paused' =>
                                        m.status == MedicationStatus.paused,
                                      'Archived' =>
                                        m.status == MedicationStatus.archived,
                                      'Low Supply' =>
                                        m.status == MedicationStatus.active &&
                                            lowIds.contains(m.clientId),
                                      _ => m.status == MedicationStatus.active,
                                    },
                              )
                              .toList();
                          final focus =
                              filtered
                                  .where((m) => m.clientId == focusedId)
                                  .firstOrNull ??
                              filtered.firstOrNull;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (final label in [
                                      'Active',
                                      'Paused',
                                      'Low Supply',
                                      'Archived',
                                    ])
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 6,
                                        ),
                                        child: ChoiceChip(
                                          label: Text(
                                            '$label (${label == 'Low Supply' ? lowIds.length : items.where((m) => m.status.name.toLowerCase() == label.toLowerCase()).length})',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                          selected: filter == label,
                                          onSelected: (_) =>
                                              setState(() => filter = label),
                                          showCheckmark: false,
                                          selectedColor: const Color(
                                            0xFF17621A,
                                          ),
                                          labelStyle: TextStyle(
                                            color: filter == label
                                                ? Colors.white
                                                : null,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          visualDensity: VisualDensity.compact,
                                          shape: const StadiumBorder(),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              if (focus == null)
                                const _EmptyMedications()
                              else ...[
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'PRIMARY FOCUS',
                                        style: TextStyle(
                                          fontSize: 11,
                                          letterSpacing: .6,
                                          fontWeight: FontWeight.w600,
                                          color: CupertinoColors.systemGrey,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '1 of ${filtered.length} selected',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: CupertinoColors.systemGrey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                MedicationDetailCard(focus, embedded: true),
                                if (filtered.length > 1) ...[
                                  const SizedBox(height: 20),
                                  Text(
                                    'OTHER MEDICATIONS',
                                    style: TextStyle(
                                      fontSize: 11,
                                      letterSpacing: .6,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  for (final medication in filtered.where(
                                    (m) => m.clientId != focus.clientId,
                                  ))
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: MedicationSurface(
                                        padding: const EdgeInsets.all(14),
                                        onTap: () => setState(
                                          () => focusedId = medication.clientId,
                                        ),
                                        child: Row(
                                          children: [
                                            const MedicationAvatar(size: 36),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    medication.displayName,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${medication.strengthLabel.isEmpty ? '' : '${medication.strengthLabel} · '}${medication.status.name}',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: CupertinoColors
                                                          .systemGrey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              CupertinoIcons.chevron_right,
                                              size: 14,
                                              color: CupertinoColors.systemGrey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                                Padding(
                                  padding: EdgeInsets.all(18),
                                  child: Text(
                                    'Qarr Track records personal medication intake and supply. It does not provide medical diagnosis or prescription advice.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyMedications extends StatelessWidget {
  const _EmptyMedications();
  @override
  Widget build(BuildContext context) => MedicationSurface(
    child: Column(
      children: [
        Icon(CupertinoIcons.capsule, size: 42, color: medicationTeal),
        const SizedBox(height: 12),
        Text(
          'No medications yet',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          'Add what you take, then set the dose and reminder schedule.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(
              context,
            ).textTheme.bodySmall?.color?.withOpacity(.65),
          ),
        ),
      ],
    ),
  );
}
