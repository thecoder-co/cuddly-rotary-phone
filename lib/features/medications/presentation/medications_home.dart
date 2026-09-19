import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/medication_models.dart';
import '../providers/medication_provider.dart';
import 'add_medication_flow.dart';
import 'today_medications_screen.dart';
import 'medications_list_screen.dart';
import 'medication_history_screen.dart';
import 'widgets/medication_ui.dart';
import '../../../core/services/notifications/notification_coordinator.dart';

class MedicationsHome extends ConsumerStatefulWidget {
  final NotificationPayload? initialPayload;
  const MedicationsHome({super.key, this.initialPayload});
  @override
  ConsumerState<MedicationsHome> createState() => _MedicationsHomeState();
}

class _MedicationsHomeState extends ConsumerState<MedicationsHome>
    with WidgetsBindingObserver {
  bool _checkingTimezone = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _reconcile());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _reconcile(sync: false);
  }

  Future<void> _reconcile({bool sync = true}) async {
    if (_checkingTimezone) return;
    _checkingTimezone = true;
    try {
      if (sync)
        await ref
            .read(medicationSyncServiceProvider)
            .syncPending(retryNow: true);
      if (!mounted) return;
      final zone = (await FlutterTimezone.getLocalTimezone()).identifier;
      tz.setLocalLocation(tz.getLocation(zone));
      final repo = ref.read(localMedicationRepoProvider);
      for (final medication in await repo.getActiveMedications()) {
        final schedules = await repo.schedulesFor(medication.clientId);
        if (schedules.isEmpty) continue;
        final schedule = schedules.first;
        if (schedule.timezone == zone ||
            schedule.timezoneBehavior !=
                MedicationTimezoneBehavior.followDevice ||
            schedule.frequency == MedicationFrequency.interval)
          continue;
        if (!mounted) return;
        final review = await showCupertinoDialog<bool>(
          context: context,
          builder: (dialogContext) => CupertinoAlertDialog(
            title: const Text('Review your timezone'),
            content: Text(
              '${medication.displayName} uses ${schedule.timezone}; your device now uses $zone. Review the next doses before changing the schedule. Until you save, the existing timezone remains in effect.',
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Keep for now'),
              ),
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: const Text('Review schedule'),
              ),
            ],
          ),
        );
        if (review == true && mounted) {
          await Navigator.of(context, rootNavigator: true).push(
            CupertinoPageRoute(
              builder: (_) => AddMedicationFlow(
                medication: medication,
                schedule: schedule,
                suggestedTimezone: zone,
              ),
            ),
          );
        }
      }
      if (mounted) await ref.read(medicationActionsProvider).refreshReminders();
    } catch (_) {
      // Permission/platform failures remain visible in reminder diagnostics.
    } finally {
      _checkingTimezone = false;
    }
  }

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      activeColor: CupertinoDynamicColor.resolve(medicationGreen, context),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.calendar_today),
          label: 'Today',
        ),
        BottomNavigationBarItem(
          icon: MedicationPillIcon(),
          label: 'Medications',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.clock),
          label: 'History',
        ),
      ],
    ),
    tabBuilder: (context, index) => CupertinoTabView(
      builder: (_) => switch (index) {
        0 => TodayMedicationsScreen(initialPayload: widget.initialPayload),
        1 => const MedicationsListScreen(),
        _ => const MedicationHistoryScreen(),
      },
    ),
  );
}
