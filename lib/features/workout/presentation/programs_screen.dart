import 'package:calorie_tracker/features/workout/presentation/exercises_screen.dart';
import 'package:calorie_tracker/features/workout/presentation/add_program_screen.dart';
import 'package:calorie_tracker/features/workout/providers/workout_provider.dart';
import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:calorie_tracker/packages/packages.dart';

class ProgramsScreen extends ConsumerStatefulWidget {
  const ProgramsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends ConsumerState<ProgramsScreen> {
  @override
  Widget build(BuildContext context) {
    final programsAsync = ref.watch(workoutProgramProvider);
    final exercisesAsync = ref.watch(workoutExerciseProvider(true));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.greenAccent.shade400;

    return CupertinoPageScaffold(
      backgroundColor: isDark
          ? CupertinoColors.black
          : CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        border: null,
        // leading: const Icon(CupertinoIcons.settings, color: CupertinoColors.systemGrey),
        middle: Text(
          'My Workouts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1C1C1E)
                      : CupertinoColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // New Workout Action
                    CupertinoListTile(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      leading: Icon(CupertinoIcons.add, color: primaryColor),
                      title: Text(
                        'New Workout...',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const AddProgramScreen(),
                          ),
                        );
                      },
                    ),
                    Divider(
                      height: 1,
                      thickness: .5,
                      color: isDark
                          ? Colors.grey.shade800
                          : Colors.grey.shade200,
                      indent: 50,
                    ),

                    // My Exercises
                    CupertinoListTile(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      leading: const Icon(
                        Icons.fitness_center,
                        color: CupertinoColors.systemGreen,
                      ),
                      title: const Text(
                        'My Exercises',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      additionalInfo: exercisesAsync.when(
                        data: (ex) => Text('${ex.length}'),
                        loading: () => const CupertinoActivityIndicator(),
                        error: (_, __) => const Text('0'),
                      ),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                const ExercisesScreen(title: 'My Exercises'),
                          ),
                        );
                      },
                    ),

                    // Programs List
                    programsAsync.when(
                      data: (programs) {
                        if (programs.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          children: programs.map((program) {
                            return Column(
                              children: [
                                const Divider(indent: 50),
                                GestureDetector(
                                  onLongPress: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            AddProgramScreen(program: program),
                                      ),
                                    );
                                  },
                                  child: CupertinoListTile(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    leading: const Icon(
                                      Icons.book,
                                      color: CupertinoColors.systemGreen,
                                    ),
                                    title: Text(
                                      program.name ?? 'Unnamed Program',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    additionalInfo: Text(
                                      '${program.exercises.length}',
                                    ),
                                    trailing: const CupertinoListTileChevron(),
                                    onTap: () {
                                      final allExercises =
                                          exercisesAsync.value ?? [];

                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => ExercisesScreen(
                                            title: program.name ?? 'Program',
                                            program: program,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        );
                      },
                      loading: () => const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CupertinoActivityIndicator(),
                      ),
                      error: (err, stack) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Error: $err',
                          style: const TextStyle(
                            color: CupertinoColors.destructiveRed,
                          ),
                        ),
                      ),
                    ),
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
