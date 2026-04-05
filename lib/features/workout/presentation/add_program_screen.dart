import 'package:calorie_tracker/core/providers/theme_provider.dart';
import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:calorie_tracker/features/workout/models/program.dart';
import 'package:calorie_tracker/features/workout/presentation/add_exercise_screen.dart';
import 'package:calorie_tracker/features/workout/providers/workout_provider.dart';
import 'package:calorie_tracker/packages/packages.dart';

class AddProgramScreen extends ConsumerStatefulWidget {
  final Program? program;

  const AddProgramScreen({super.key, this.program});

  @override
  ConsumerState<AddProgramScreen> createState() => _AddProgramScreenState();
}

class _AddProgramScreenState extends ConsumerState<AddProgramScreen> {
  late final TextEditingController _nameController;
  final Set<String> _selectedExerciseIds = {};

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.program?.name ?? '');
    if (widget.program != null) {
      for (var pe in widget.program!.exercises) {
        if (pe.exerciseId != null) {
          _selectedExerciseIds.add(pe.exerciseId!);
        }
      }
    }
  }

  final otherExercises = <Exercise>[];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveProgram() async {
    if (_nameController.text.trim().isEmpty) {
      // Show error or just return
      return;
    }

    final List<ProgramExercise> exercises = _selectedExerciseIds.map((id) {
      return ProgramExercise()..exerciseId = id;
    }).toList();

    final program = widget.program ?? Program();
    program.name = _nameController.text.trim();
    program.exercises = exercises;

    if (widget.program == null) {
      await ref.read(workoutProgramProvider.notifier).addProgram(program);
    } else {
      await ref
          .read(workoutProgramProvider.notifier)
          .updateProgram(program, program.backendId);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(workoutExerciseProvider(true));
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Material(
      type: MaterialType.transparency,
      child: CupertinoPageScaffold(
        backgroundColor: isDark
            ? CupertinoColors.black
            : CupertinoColors.systemGroupedBackground,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: const Color(0xFF000000).withOpacity(0.8),
          middle: Text(
            widget.program == null ? 'New Workout' : 'Edit Workout',
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.back, color: Color(0xFF2ECC71)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _saveProgram,
            child: const Text(
              'Done',
              style: TextStyle(
                color: Color(0xFF2ECC71),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Header Folder Icon
                    Center(
                      child: Container(
                        width: 100,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2ECC71),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          CupertinoIcons.folder_fill,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // NAME Section
                    const Text(
                      'NAME',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppInput(
                      controller: _nameController,
                      hintText: 'Upper Body, Monday, Triceps...',
                      backgroundColor: isDark ? null : Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Common naming conventions include: Workout Name, Muscle Group, Day of the Week, etc.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // SELECTIONS Section
                    const Text(
                      'SELECTIONS',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    exercisesAsync.when(
                      data: (myExercises) {
                        final exercises = [...myExercises, ...otherExercises];

                        return Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1C1C1E)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...exercises.map((exercise) {
                                final isSelected = _selectedExerciseIds
                                    .contains(
                                      exercise.backendId ??
                                          exercise.id.toString(),
                                    );
                                final bool isLast = exercises.last == exercise;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      final id =
                                          exercise.backendId ??
                                          exercise.id.toString();
                                      if (isSelected) {
                                        _selectedExerciseIds.remove(id);
                                      } else {
                                        _selectedExerciseIds.add(id);
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: isDark
                                              ? const Color(0xFF38383A)
                                              : Colors.grey,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        // Custom Selection Circle
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: isSelected
                                                  ? const Color(0xFF2ECC71)
                                                  : Colors.grey,
                                              width: 2,
                                            ),
                                            color: isSelected
                                                ? const Color(0xFF2ECC71)
                                                : Colors.transparent,
                                          ),
                                          child: isSelected
                                              ? const Icon(
                                                  Icons.check,
                                                  size: 16,
                                                  color: Colors.black,
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            exercise.name ?? 'Unknown',
                                            style: TextStyle(
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              InkWell(
                                onTap: () async {
                                  final List<Exercise>? result =
                                      await Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (_) => AddExerciseScreen(
                                            initialSelectedIds:
                                                _selectedExerciseIds.toList(),
                                          ),
                                        ),
                                      );
                                  if (result != null) {
                                    setState(() {
                                      final filtered = result.where(
                                        (e) => !exercises
                                            .map((e) => e.backendId)
                                            .contains(e.backendId),
                                      );
                                      for (var e in result) {
                                        _selectedExerciseIds.add(
                                          e.backendId ?? e.id.toString(),
                                        );
                                      }
                                      otherExercises.addAll(filtered);
                                    });
                                  }
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 14,
                                        ),
                                        child: Text(
                                          'Others',
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ].toList(),
                          ),
                        );
                      },
                      loading: () =>
                          const Center(child: CupertinoActivityIndicator()),
                      error: (e, s) => Text(
                        'Error: $e',
                        style: const TextStyle(color: Colors.red),
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
