import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/services/local_data/local_data.dart';
import '../../../core/services/notifications/notification_coordinator.dart';
import '../providers/medication_provider.dart';
import 'medication_history_screen.dart';
import 'widgets/medication_ui.dart';

class MedicationSettingsScreen extends ConsumerStatefulWidget {
  const MedicationSettingsScreen({super.key});
  @override
  ConsumerState<MedicationSettingsScreen> createState() =>
      _MedicationSettingsScreenState();
}

class _MedicationSettingsScreenState
    extends ConsumerState<MedicationSettingsScreen> {
  bool reminders = true, sound = true, vibration = true;
  int snooze = 15;
  String privacy = 'Private';

  @override
  void initState() {
    super.initState();
    reminders = LocalData.prefs.getBool('medication_reminders') ?? true;
    sound = LocalData.prefs.getBool('medication_sound') ?? true;
    vibration = LocalData.prefs.getBool('medication_vibration') ?? true;
    snooze = LocalData.prefs.getInt('medication_snooze') ?? 15;
    privacy = LocalData.prefs.getString('medication_privacy') ?? 'Private';
  }

  @override
  Widget build(BuildContext context) => MedicationPageScaffold(
    backgroundColor: medicationPageColor(context),
    child: CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: const Text('Medication Settings'),
          previousPageTitle: 'Settings',
          backgroundColor: medicationPageColor(context),
          border: null,
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          sliver: SliverList.list(
            children: [
              const _Label('SYSTEM PERMISSIONS & DIAGNOSTICS'),
              MedicationSurface(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _SettingsRow(
                      icon: CupertinoIcons.bell_fill,
                      title: 'Notifications',
                      subtitle: 'Required for dose alerts',
                      trailing: FutureBuilder<PermissionStatus>(
                        future: Permission.notification.status,
                        builder: (_, snapshot) {
                          final active = snapshot.data?.isGranted == true;
                          return Text(
                            active ? 'Active' : 'Needs setup',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: active ? medicationGreen : medicationDue,
                            ),
                          );
                        },
                      ),
                      onTap: _requestNotifications,
                    ),
                    const Divider(height: .5, indent: 54),
                    _SettingsRow(
                      icon: CupertinoIcons.clock_fill,
                      title: 'Exact alarms',
                      subtitle: 'Android may require separate access',
                      trailing: Text(
                        'Device setting',
                        style: TextStyle(
                          fontSize: 12,
                          color: medicationSnoozed,
                        ),
                      ),
                      onTap: () async {
                        await NotificationCoordinator.instance
                            .requestExactAlarmsPermission();
                        if (!mounted) return;
                        await ref
                            .read(medicationActionsProvider)
                            .refreshReminders();
                      },
                    ),
                    const Divider(height: .5, indent: 54),
                    _SettingsRow(
                      icon: CupertinoIcons.check_mark_circled_solid,
                      title: 'Reminder diagnostic',
                      subtitle: 'Timezone, permissions and next alerts',
                      trailing: Text(
                        'Run',
                        style: TextStyle(color: medicationGreen),
                      ),
                      onTap: _showDiagnostic,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const _Label('LOCK SCREEN PRIVACY'),
              MedicationSurface(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (final value in ['Full', 'Private', 'Hidden'])
                      Semantics(
                        selected: privacy == value,
                        child: _CupertinoSettingsTile(
                          onTap: () async {
                            setState(() => privacy = value);
                            await LocalData.prefs.setString(
                              'medication_privacy',
                              value,
                            );
                            await ref
                                .read(medicationActionsProvider)
                                .refreshReminders();
                          },
                          trailing: privacy == value
                              ? Icon(
                                  CupertinoIcons.check_mark,
                                  color: CupertinoDynamicColor.resolve(
                                    medicationGreen,
                                    context,
                                  ),
                                )
                              : const SizedBox(width: 20),
                          title: Text(
                            value == 'Private'
                                ? 'Private (recommended)'
                                : value,
                          ),
                          subtitle: Text(switch (value) {
                            'Full' =>
                              'Show medication name, quantity and instructions',
                            'Private' =>
                              'Show “Medication reminder” and quantity',
                            _ => 'Show only “You have a health reminder”',
                          }),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const _Label('REMINDER TIMING & ACTIONS'),
              MedicationSurface(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _CupertinoSwitchTile(
                      title: Text('Medication reminders'),
                      value: reminders,
                      onChanged: (value) async {
                        setState(() => reminders = value);
                        await LocalData.prefs.setBool(
                          'medication_reminders',
                          value,
                        );
                        await ref
                            .read(medicationActionsProvider)
                            .refreshReminders();
                      },
                    ),
                    _CupertinoSettingsTile(
                      title: const Text('Default snooze duration'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('$snooze min'),
                          const SizedBox(width: 8),
                          const CupertinoListTileChevron(),
                        ],
                      ),
                      onTap: _showSnoozePicker,
                    ),
                    _CupertinoSwitchTile(
                      title: Text('Reminder sound'),
                      value: sound,
                      onChanged: (value) async {
                        setState(() => sound = value);
                        await LocalData.prefs.setBool(
                          'medication_sound',
                          value,
                        );
                        await ref
                            .read(medicationActionsProvider)
                            .refreshReminders();
                      },
                    ),
                    _CupertinoSwitchTile(
                      title: Text('Vibration'),
                      value: vibration,
                      onChanged: (value) async {
                        setState(() => vibration = value);
                        await LocalData.prefs.setBool(
                          'medication_vibration',
                          value,
                        );
                        await ref
                            .read(medicationActionsProvider)
                            .refreshReminders();
                      },
                    ),
                    const _CupertinoSettingsTile(
                      title: Text('Timezone policy'),
                      subtitle: Text(
                        'Set per medication in Edit Regimen & Reminders',
                      ),
                      trailing: Text(
                        'Per schedule',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const _Label('DATA & CLINICAL SHARING'),
              MedicationSurface(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _CupertinoSettingsTile(
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => const MedicationHistoryScreen(),
                        ),
                      ),
                      leading: Icon(
                        CupertinoIcons.doc_text_fill,
                        color: CupertinoDynamicColor.resolve(
                          medicationGreen,
                          context,
                        ),
                      ),
                      title: Text('Export medication log'),
                      subtitle: Text(
                        'Open History to save a PDF or CSV report',
                      ),
                    ),
                    _CupertinoSettingsTile(
                      leading: Icon(
                        CupertinoIcons.delete_solid,
                        color: medicationMissed,
                      ),
                      title: Text(
                        'Delete all medication data',
                        style: TextStyle(color: medicationMissed),
                      ),
                      subtitle: Text(
                        'Permanently removes medication details, history and reminders',
                      ),
                      onTap: _confirmDelete,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Reminders are an aid for tracking. Always follow your prescriber’s or medication label instructions and consult a qualified health professional for clinical decisions.',
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
      ],
    ),
  );

  Future<void> _showSnoozePicker() async {
    const durations = [10, 15, 20, 30, 60];
    var selected = snooze;
    final controller = FixedExtentScrollController(
      initialItem: durations.indexOf(snooze),
    );
    final value = await showCupertinoModalPopup<int>(
      context: context,
      builder: (context) => Container(
        height: 300,
        color: CupertinoDynamicColor.resolve(
          CupertinoColors.systemBackground,
          context,
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  CupertinoButton(
                    onPressed: () => Navigator.pop(context, selected),
                    child: const Text('Done'),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: controller,
                  itemExtent: 40,
                  onSelectedItemChanged: (index) => selected = durations[index],
                  children: [
                    for (final duration in durations)
                      Center(child: Text('$duration min')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    controller.dispose();
    if (value == null || !mounted) return;
    setState(() => snooze = value);
    await LocalData.prefs.setInt('medication_snooze', value);
  }

  Future<void> _requestNotifications() async {
    final status = await Permission.notification.request();
    if (status.isPermanentlyDenied) await openAppSettings();
    setState(() {});
  }

  Future<void> _showDiagnostic() async {
    final health = await NotificationCoordinator.instance.health();
    if (!mounted) return;
    await showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text('Reminder diagnostic'),
        content: Text(
          'Notifications: ${health['notifications'] == false ? 'Off — enable alerts in device settings' : 'Enabled'}\nScheduled reminders: ${health['scheduledCount']}\nTimezone: ${health['timezone']}\n${health['exactAlarms'] == false ? 'Approximate timing: Android exact-alarm access is off. Reminders may be delayed.' : 'Reminder timing is managed by your device.'}',
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text('Done'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete() => showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text('Delete medication data?'),
      content: Text(
        'This permanently removes medication details, history, supply records and scheduled reminders. Archive individual medications to preserve history.',
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () async {
            Navigator.pop(context);
            await ref.read(medicationActionsProvider).clearMedicationData();
            if (!mounted) return;
            await showCupertinoDialog<void>(
              context: context,
              builder: (_) => CupertinoAlertDialog(
                title: Text('Medication data deleted'),
                content: Text(
                  'Local medication details, history, supply data and reminders were removed. Server deletion will retry safely if you are offline.',
                ),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Done'),
                  ),
                ],
              ),
            );
          },
          child: Text('Delete permanently'),
        ),
      ],
    ),
  );
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(4, 0, 0, 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(.55),
      ),
    ),
  );
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final Widget trailing;
  final VoidCallback? onTap;
  _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) => _CupertinoSettingsTile(
    onTap: onTap,
    leading: Icon(icon, color: medicationGreen),
    title: Text(title),
    subtitle: Text(subtitle),
    trailing: trailing,
  );
}

class _CupertinoSettingsTile extends StatelessWidget {
  const _CupertinoSettingsTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final Widget title;
  final Widget? subtitle, leading, trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => CupertinoListTile(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    leading: leading,
    title: DefaultTextStyle.merge(
      maxLines: 3,
      overflow: TextOverflow.visible,
      child: title,
    ),
    subtitle: subtitle == null
        ? null
        : DefaultTextStyle.merge(
            maxLines: 5,
            overflow: TextOverflow.visible,
            child: subtitle!,
          ),
    trailing:
        trailing ?? (onTap == null ? null : const CupertinoListTileChevron()),
    onTap: onTap,
  );
}

class _CupertinoSwitchTile extends StatelessWidget {
  const _CupertinoSwitchTile({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final Widget title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => _CupertinoSettingsTile(
    title: title,
    trailing: CupertinoSwitch(
      value: value,
      activeTrackColor: CupertinoDynamicColor.resolve(medicationGreen, context),
      onChanged: onChanged,
    ),
  );
}
