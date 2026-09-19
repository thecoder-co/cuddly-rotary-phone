import 'package:calorie_tracker/core/dialogs/dialog.dart';
import 'package:calorie_tracker/core/providers/theme_provider.dart';
import 'package:calorie_tracker/core/services/local_data/isar_service.dart';
import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/core/providers/session_controller.dart';
import 'package:calorie_tracker/features/auth/presentation/register_screen.dart';
import 'package:calorie_tracker/features/user/presentation/meal_settings_screen.dart';
import 'package:calorie_tracker/features/user/presentation/workout_settings_screen.dart';
import 'package:calorie_tracker/features/user/providers/user_provider.dart';
import 'package:calorie_tracker/packages/packages.dart';
import 'package:flutter/cupertino.dart';
import '../../medications/presentation/medication_settings_screen.dart';
import '../../../core/services/notifications/notification_coordinator.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;
    final isGuest = LocalData.userType == 'ANONYMOUS';
    final profileName = userAsync.value?.name ?? LocalData.userName ?? 'Guest';
    final profileEmail = userAsync.value?.email ?? LocalData.userEmail;

    return CupertinoPageScaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : CupertinoColors.systemGroupedBackground,
      child: Material(
        color: Colors.transparent,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Settings'),
              backgroundColor: isDark
                  ? const Color(0xFF121212)
                  : CupertinoColors.systemGroupedBackground,
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? Colors.white.withOpacity(0.08)
                      : Colors.black.withOpacity(0.06),
                  width: 0.5,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Avatar card ─────────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary.withOpacity(0.15),
                              border: Border.all(
                                color: AppColors.primary300,
                                width: 1.5,
                              ),
                            ),
                            child:
                                userAsync.whenOrNull(
                                  data: (user) => Center(
                                    child: Text(
                                      (user?.name ?? profileName)
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      style: CustomTextStyle.textxLarge20.w700
                                          .withColor(AppColors.primary300)
                                          .copyWith(fontSize: 22),
                                    ),
                                  ),
                                ) ??
                                const Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profileName,
                                  style: CustomTextStyle.textmedium16.w700,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  isGuest
                                      ? 'Guest account'
                                      : profileEmail ?? '—',
                                  style: CustomTextStyle.textsmall14.withColor(
                                    AppColors.greyTertiary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Appearance ──────────────────────────────────────────
                    const _SectionLabel('Appearance'),
                    _SettingsTile(
                      icon: isDark
                          ? CupertinoIcons.moon_fill
                          : CupertinoIcons.sun_max_fill,
                      title: 'Dark Mode',
                      trailing: CupertinoSwitch(
                        value: isDark,
                        activeTrackColor: AppColors.primary,
                        onChanged: (_) =>
                            ref.read(themeModeProvider.notifier).toggle(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Module Settings ──────────────────────────────────────
                    const _SectionLabel('Module Settings'),
                    _SettingsTile(
                      icon: CupertinoIcons.flame,
                      title: 'Meal Settings',
                      iconColor: Colors.orange,
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => const MealSettingsScreen(),
                          ),
                        );
                      },
                    ),
                    _SettingsTile(
                      icon: CupertinoIcons.sportscourt,
                      title: 'Workout Settings',
                      iconColor: CupertinoColors.systemGreen,
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => const WorkoutSettingsScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _SettingsTile(
                      icon: CupertinoIcons.capsule,
                      title: 'Medication Settings',
                      iconColor: CupertinoColors.systemGreen,
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => const MedicationSettingsScreen(),
                        ),
                      ),
                    ),
                    const _SectionLabel('Account'),
                    _SettingsTile(
                      icon: CupertinoIcons.person_crop_circle_badge_checkmark,
                      title: 'Account type',
                      subtitle: isGuest ? 'Guest' : 'Email account',
                    ),
                    _SettingsTile(
                      icon: CupertinoIcons.person,
                      title: 'Name',
                      subtitle: profileName,
                    ),
                    _SettingsTile(
                      icon: CupertinoIcons.mail,
                      title: 'Email',
                      subtitle: profileEmail ?? (isGuest ? 'Not linked' : null),
                    ),
                    if (isGuest)
                      _SettingsTile(
                        icon: CupertinoIcons.link,
                        title: 'Link email',
                        subtitle:
                            'Keep this account if you reinstall or change devices',
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) =>
                                const RegisterScreen(isGuestUpgrade: true),
                          ),
                        ),
                      ),
                    if (LocalData.prefs.getBool(
                          'accountDataReconciliationNeeded:${LocalData.userId}',
                        ) ==
                        true)
                      const _SettingsTile(
                        icon: CupertinoIcons.exclamationmark_triangle,
                        title: 'Local data needs review',
                        subtitle:
                            'Older shared meals or workout sets were kept separate until you choose how to reconcile them.',
                        iconColor: CupertinoColors.systemOrange,
                      ),
                    const SizedBox(height: 20),

                    // ── Danger zone ─────────────────────────────────────────
                    const _SectionLabel('Account Actions'),
                    _SettingsTile(
                      icon: CupertinoIcons.square_arrow_right,
                      title: 'Sign Out',
                      titleColor: AppColors.error500,
                      iconColor: AppColors.error500,
                      onTap: () async {
                        await ref.read(sessionProvider.notifier).signOut();
                      },
                    ),
                    _SettingsTile(
                      icon: CupertinoIcons.trash,
                      title: 'Clear Local Data',
                      subtitle: 'Remove this account’s data from this device',
                      titleColor: AppColors.error500,
                      iconColor: AppColors.error500,
                      onTap: () async {
                        final confirmed = await Dialogs.confirmDialog(
                          title: 'Clear Local Data',
                          subtitle:
                              'This removes local meals, exercises, workouts, and this account’s medication records, including unsynced changes, and cancels medication reminders. Cloud records are not deleted and may download again. This action cannot be undone.',
                          yesText: 'Clear All',
                          noText: 'Cancel',
                        );

                        if (confirmed) {
                          try {
                            for (final key
                                in LocalData.prefs
                                    .getKeys()
                                    .where(
                                      (key) => key.startsWith(
                                        'medication_scheduled_',
                                      ),
                                    )
                                    .toList()) {
                              for (final occurrence
                                  in LocalData.prefs.getStringList(key) ??
                                      <String>[]) {
                                await NotificationCoordinator.instance
                                    .cancelMedication(occurrence);
                              }
                              await LocalData.prefs.remove(key);
                            }
                            await IsarService.clearAll();
                            AppToast.success('Local data cleared successfully');
                          } catch (e) {
                            AppToast.error('Failed to clear data: $e');
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 32),
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

// ---------------------------------------------------------------------------
// Helper widgets
// ---------------------------------------------------------------------------

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        label.toUpperCase(),
        style: CustomTextStyle.textsmall14
            .withColor(AppColors.greyTertiary)
            .copyWith(fontSize: 11, letterSpacing: 1.1),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;
  final Color? iconColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.titleColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final effectiveIconColor = iconColor ?? AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: effectiveIconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: effectiveIconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CustomTextStyle.textsmall14.w600.withColor(
                      titleColor ??
                          (isDark ? Colors.white : AppColors.primary900),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: CustomTextStyle.textsmall14.withColor(
                        AppColors.greyTertiary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing!,
            if (trailing == null && onTap != null)
              const Icon(
                CupertinoIcons.chevron_right,
                color: AppColors.greySecondary,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
