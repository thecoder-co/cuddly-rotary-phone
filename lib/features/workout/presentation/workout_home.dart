import 'package:calorie_tracker/features/workout/presentation/exercises_screen.dart';
import 'package:calorie_tracker/features/workout/presentation/programs_screen.dart';
import 'package:calorie_tracker/features/workout/presentation/analytics_placeholder_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutHome extends ConsumerStatefulWidget {
  const WorkoutHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WorkoutHomeState();
}

class _WorkoutHomeState extends ConsumerState<WorkoutHome> {
  final CupertinoTabController _tabController = CupertinoTabController();

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: isDark
            ? const Color(0xFF121212)
            : Colors.white,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: CupertinoTabScaffold(
        controller: _tabController,
        backgroundColor: isDark
            ? CupertinoColors.black
            : CupertinoColors.systemGroupedBackground,
        tabBar: CupertinoTabBar(
          activeColor: CupertinoColors.systemGreen,
          height: 60,
          backgroundColor: isDark
              ? const Color(0xFF1C1C1E)
              : CupertinoColors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Programs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'My Workouts',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar_today),
              label: 'Today',
            ),
          ],
        ),
        tabBuilder: (context, i) {
          switch (i) {
            case 0:
              return const ProgramsScreen();
            case 1:
              return const ExercisesScreen(title: 'My Workouts');
            case 2:
              return const AnalyticsPlaceholderScreen();
            default:
              return const ProgramsScreen();
          }
        },
      ),
    );
  }
}
