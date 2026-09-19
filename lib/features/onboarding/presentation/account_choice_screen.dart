import 'package:calorie_tracker/features/auth/models/auth_dto.dart';
import 'package:calorie_tracker/features/auth/presentation/login_screen.dart';
import 'package:calorie_tracker/features/auth/presentation/register_screen.dart';
import 'package:calorie_tracker/features/auth/providers/auth_provider.dart';
import 'package:calorie_tracker/packages/packages.dart';

class AccountChoiceScreen extends StatelessWidget {
  const AccountChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark
        ? const Color(0xFF101912)
        : const Color(0xFFF1FAF1);
    return CupertinoPageScaffold(
      backgroundColor: background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const QarrTrackWordmark(),
              const Spacer(),
              const Icon(
                CupertinoIcons.heart_circle_fill,
                color: AppColors.primary,
                size: 72,
                semanticLabel: 'QarrTrack',
              ),
              const SizedBox(height: 28),
              Text(
                'Track what matters to you.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: isDark ? Colors.white : const Color(0xFF173A1D),
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Create an account to keep your tracking data across devices, or start as a guest on this device.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark ? Colors.white70 : const Color(0xFF4C6350),
                  height: 1.45,
                ),
              ),
              const Spacer(flex: 2),
              AppButton(
                label: 'Get started',
                onPressed: () => Navigator.of(context).push(
                  CupertinoPageRoute(builder: (_) => const RegisterScreen()),
                ),
              ),
              const SizedBox(height: 12),
              AppButton.outline(
                label: 'Sign in',
                onPressed: () => Navigator.of(
                  context,
                ).push(CupertinoPageRoute(builder: (_) => const LoginScreen())),
              ),
              const SizedBox(height: 8),
              CupertinoButton(
                onPressed: () => _showGuestSheet(context),
                child: const Text('Use anonymously'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGuestSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (_) => const GuestNameSheet(),
    );
  }
}

class GuestNameSheet extends ConsumerStatefulWidget {
  const GuestNameSheet({super.key});

  @override
  ConsumerState<GuestNameSheet> createState() => _GuestNameSheetState();
}

class _GuestNameSheetState extends ConsumerState<GuestNameSheet> {
  final _nameController = TextEditingController();
  String? _error;
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (name.isEmpty) {
      setState(() => _error = 'Enter a name to continue.');
      return;
    }
    if (name.length > 100) {
      setState(() => _error = 'Use 100 characters or fewer.');
      return;
    }
    setState(() {
      _error = null;
      _submitting = true;
    });
    final failureMessage = await ref
        .read(authProvider.notifier)
        .registerAnonymous(model: AnonymousRegisterDto(name: name));
    if (!mounted) return;
    if (failureMessage == null) {
      Navigator.of(context).pop();
      return;
    }
    setState(() {
      _submitting = false;
      _error = failureMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return CupertinoPopupSurface(
      isSurfacePainted: true,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            24 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Continue as guest',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose a name for this device. Link an email later to recover this account on another device or after reinstalling.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.white70 : Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                CupertinoTextField(
                  key: const ValueKey('guest-name-field'),
                  controller: _nameController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  maxLength: 100,
                  onChanged: (_) {
                    if (_error != null) setState(() => _error = null);
                  },
                  placeholder: 'Your name',
                  padding: const EdgeInsets.all(14),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: const TextStyle(color: CupertinoColors.systemRed),
                  ),
                ],
                const SizedBox(height: 20),
                AppButton(
                  key: const ValueKey('guest-submit-button'),
                  label: _submitting
                      ? 'Creating account…'
                      : 'Continue as guest',
                  onPressed: _submitting ? null : _submit,
                ),
                CupertinoButton(
                  onPressed: _submitting ? null : () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QarrTrackWordmark extends StatelessWidget {
  const QarrTrackWordmark({super.key});

  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    label: 'QarrTrack',
    child: Text(
      'QARRTRACK',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.6,
      ),
    ),
  );
}
