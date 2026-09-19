import 'package:calorie_tracker/core/providers/session_controller.dart';
import 'package:calorie_tracker/features/auth/presentation/login_screen.dart';
import 'package:calorie_tracker/features/auth/presentation/register_screen.dart';
import 'package:calorie_tracker/features/onboarding/models/intro_page.dart';
import 'package:calorie_tracker/features/onboarding/presentation/account_choice_screen.dart';
import 'package:calorie_tracker/packages/packages.dart';

class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen({super.key});

  @override
  ConsumerState<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  static const _pages = [
    IntroPage(
      title: 'Meals made simple',
      description:
          'Log meals, see calories and macros, and build routines that fit your day.',
      icon: CupertinoIcons.flame_fill,
      accent: Color(0xFF17621A),
    ),
    IntroPage(
      title: 'Make every workout count',
      description:
          'Plan exercises, record sets and keep your progress close at hand.',
      icon: CupertinoIcons.sportscourt_fill,
      accent: Color(0xFF1565C0),
    ),
    IntroPage(
      title: 'Spend with clarity',
      description:
          'Budget tracking is on the way. We will clearly label it until it is ready.',
      icon: CupertinoIcons.creditcard_fill,
      accent: Color(0xFF7B1FA2),
      comingSoon: true,
    ),
    IntroPage(
      title: 'Notice your mood',
      description:
          'Mood tracking is coming soon, with private reflections and a clearer history.',
      icon: CupertinoIcons.heart_fill,
      accent: Color(0xFFD8436A),
      comingSoon: true,
    ),
  ];

  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _skip() async {
    await ref.read(sessionProvider.notifier).markOnboardingComplete();
  }

  void _openRegistration() => Navigator.of(
    context,
  ).push(CupertinoPageRoute(builder: (_) => const RegisterScreen()));

  void _openLogin() => Navigator.of(
    context,
  ).push(CupertinoPageRoute(builder: (_) => const LoginScreen()));

  void _openGuest() => showCupertinoModalPopup<void>(
    context: context,
    builder: (_) => const GuestNameSheet(),
  );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark
        ? const Color(0xFF101912)
        : const Color(0xFFF1FAF1);
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 12),
              child: Row(
                children: [
                  const Expanded(child: QarrTrackWordmark()),
                  CupertinoButton(
                    minimumSize: const Size.square(44),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    onPressed: _skip,
                    child: const Text('Skip'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (value) => setState(() => _index = value),
                itemBuilder: (context, index) =>
                    _IntroFeaturePage(page: _pages[index]),
              ),
            ),
            _PageIndicators(
              currentIndex: _index,
              count: _pages.length,
              onSelected: (index) => _controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOut,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppButton(label: 'Get started', onPressed: _openRegistration),
                  const SizedBox(height: 10),
                  AppButton.outline(label: 'Sign in', onPressed: _openLogin),
                  CupertinoButton(
                    onPressed: _openGuest,
                    child: const Text('Use anonymously'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroFeaturePage extends StatelessWidget {
  final IntroPage page;
  const _IntroFeaturePage({required this.page});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxHeight < 390;
        final illustrationSize = compact ? 128.0 : 188.0;
        final illustrationIconSize = compact ? 60.0 : 88.0;
        final headlineGap = compact ? 22.0 : 42.0;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Semantics(
                  image: true,
                  label: '${page.title} feature illustration',
                  child: Container(
                    width: illustrationSize,
                    height: illustrationSize,
                    decoration: BoxDecoration(
                      color: page.accent.withValues(alpha: isDark ? .24 : .12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      page.icon,
                      size: illustrationIconSize,
                      color: page.accent,
                    ),
                  ),
                ),
                SizedBox(height: headlineGap),
                if (page.comingSoon)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: page.accent.withValues(alpha: .14),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      'COMING SOON',
                      style: TextStyle(
                        color: page.accent,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        letterSpacing: .8,
                      ),
                    ),
                  ),
                if (page.comingSoon) const SizedBox(height: 14),
                Text(
                  page.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: isDark ? Colors.white : const Color(0xFF173A1D),
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  page.description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isDark ? Colors.white70 : const Color(0xFF4C6350),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PageIndicators extends StatelessWidget {
  final int currentIndex;
  final int count;
  final ValueChanged<int> onSelected;
  const _PageIndicators({
    required this.currentIndex,
    required this.count,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Introduction page ${currentIndex + 1} of $count',
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => Semantics(
          button: true,
          selected: index == currentIndex,
          label: 'Go to introduction page ${index + 1}',
          child: GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              width: index == currentIndex ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: index == currentIndex
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: .25),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
