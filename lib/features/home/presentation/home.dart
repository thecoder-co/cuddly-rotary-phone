import 'package:calorie_tracker/features/meals_home/presentation/home.dart';
import 'package:calorie_tracker/features/user/presentation/settings_screen.dart';
import 'package:calorie_tracker/features/auth/providers/auth_provider.dart';
import 'package:calorie_tracker/features/user/providers/user_provider.dart';
import 'package:calorie_tracker/features/workout/presentation/workout_home.dart';
import 'package:calorie_tracker/packages/packages.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProvider.notifier).refreshTokenOnStartup();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);

    final topPad = MediaQuery.paddingOf(context).top;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: isDark ? Theme.of(context).scaffoldBackgroundColor : null,
          gradient: isDark
              ? null
              : const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFCAF2CB),
                    Color(0xFFE8F8E8),
                    Color(0xFFF5FDF5),
                  ],
                ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: topPad > 0 ? 8 : 24),
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good day 👋',
                          style: CustomTextStyle.textsmall14.withColor(
                            AppColors.primary600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'What are you\ntracking today?',
                          style: CustomTextStyle.textxLarge20.w700.withColor(
                            isDark ? Colors.white : AppColors.primary900,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => pushTo(const SettingsScreen()),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary200,
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: AppColors.primary,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Category grid
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.88,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _CategoryCard(
                        label: 'Meals',
                        subtitle: 'Track calories\n& macros',
                        icon: Icons.restaurant_menu_rounded,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF17621A), Color(0xFF3A7F3A)],
                        ),
                        iconBgColor: Colors.white.withOpacity(0.18),
                        onTap: () => pushTo(const MealsHome()),
                      ),
                      _CategoryCard(
                        label: 'Workouts',
                        subtitle: 'Log your\nexercise',
                        icon: Icons.fitness_center_rounded,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                        ),
                        iconBgColor: Colors.white.withOpacity(0.18),
                        onTap: () {
                          pushTo(const WorkoutHome());
                        },
                      ),
                      _CategoryCard(
                        label: 'Spending',
                        subtitle: 'Monitor your\nbudget',
                        icon: Icons.wallet_rounded,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
                        ),
                        iconBgColor: Colors.white.withOpacity(0.18),
                        onTap: () {},
                        comingSoon: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String label;
  final String subtitle;
  final IconData icon;
  final LinearGradient gradient;
  final Color iconBgColor;
  final VoidCallback onTap;
  final bool comingSoon;

  const _CategoryCard({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.iconBgColor,
    required this.onTap,
    this.comingSoon = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: gradient.colors.first.withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background pattern circle
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.07),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: -30,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon bubble
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(icon, color: Colors.white, size: 24),
                    ),
                    const Spacer(),
                    Text(
                      label,
                      style: CustomTextStyle.textmedium16.w700.withColor(
                        Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: CustomTextStyle.textsmall14.withColor(
                        Colors.white.withOpacity(0.75),
                      ),
                    ),
                    if (comingSoon) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Coming soon',
                          style: CustomTextStyle.textsmall14
                              .withColor(Colors.white)
                              .copyWith(fontSize: 10),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
