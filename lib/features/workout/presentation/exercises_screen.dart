import 'package:calorie_tracker/features/workout/models/program.dart';
import 'package:calorie_tracker/features/workout/models/workout_set.dart';
import 'package:calorie_tracker/features/workout/presentation/add_exercise_screen.dart';
import 'package:calorie_tracker/features/workout/presentation/add_program_screen.dart';
import 'package:calorie_tracker/features/workout/presentation/exercise_details_screen.dart';
import 'package:calorie_tracker/features/workout/providers/program_provider.dart';
import 'package:calorie_tracker/features/workout/providers/workout_provider.dart';
import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:calorie_tracker/features/workout/providers/workout_set_provider.dart';
import 'package:calorie_tracker/features/workout/services/workout_sync_service.dart';
import 'package:calorie_tracker/packages/packages.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExercisesScreen extends ConsumerStatefulWidget {
  final String title;
  final Program? program;

  const ExercisesScreen({super.key, this.title = 'Exercises', this.program});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExercisesScreenState();
}

class _ExercisesScreenState extends ConsumerState<ExercisesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = widget.program != null
        ? ref.watch(workoutProgramExerciseProvider(widget.program!.id))
        : ref.watch(workoutExerciseProvider(true));

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.greenAccent.shade400;

    return CupertinoPageScaffold(
      backgroundColor: isDark
          ? CupertinoColors.black
          : CupertinoColors.systemGroupedBackground,
      child: Material(
        borderRadius: BorderRadius.zero,
        color: Colors.transparent,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              previousPageTitle: 'Back',
              largeTitle: Text(widget.title),
            ),
            SliverSafeArea(
              top: false,
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CupertinoSearchTextField(
                        controller: _searchController,
                        placeholder: 'Search',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        Widget buildList(List<Exercise> exerciseList) {
                          final query = _searchController.text.toLowerCase();
                          final filtered = exerciseList
                              .where(
                                (e) => (e.name ?? '').toLowerCase().contains(
                                  query,
                                ),
                              )
                              .toList();

                          return ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                    ...filtered.asMap().entries.map((entry) {
                                      final int idx = entry.key;
                                      final Exercise exercise = entry.value;
                                      final setBackendId =
                                          exercise.backendId ??
                                          'local_${exercise.id}';
                                      final setsAsync = ref.watch(
                                        workoutSetProvider(setBackendId),
                                      );
                                      final lastUsed =
                                          setsAsync.value?.firstOrNull?.date;

                                      return Column(
                                        children: [
                                          if (idx > 0)
                                            Divider(
                                              height: 1,
                                              color: isDark
                                                  ? Colors.grey.shade800
                                                  : Colors.grey.shade200,
                                              indent: 16,
                                            ),
                                          Slidable(
                                            key: ValueKey(exercise.id),
                                            startActionPane: ActionPane(
                                              motion: const BehindMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (_) {
                                                    final backendId =
                                                        exercise.backendId ??
                                                        'local_${exercise.id}';
                                                    final sets = setsAsync
                                                        .whenData((s) => s)
                                                        .value;
                                                    WorkoutSet? lastSet;
                                                    if (sets != null &&
                                                        sets.isNotEmpty) {
                                                      final sorted = [...sets]
                                                        ..sort((a, b) {
                                                          final aDate =
                                                              a.date ??
                                                              DateTime(2000);
                                                          final bDate =
                                                              b.date ??
                                                              DateTime(2000);
                                                          return bDate
                                                              .compareTo(aDate);
                                                        });
                                                      lastSet = sorted.first;
                                                    }
                                                    ref
                                                        .read(
                                                          workoutSetProvider(
                                                            backendId,
                                                          ).notifier,
                                                        )
                                                        .showAddSetModal(
                                                          exercise.name ??
                                                              'Rest',
                                                          backendId,
                                                          lastSet,
                                                        );
                                                  },
                                                  backgroundColor: isDark
                                                      ? Colors.green.shade900
                                                            .withValues(
                                                              alpha: 0.5,
                                                            )
                                                      : Colors.green.shade100,
                                                  foregroundColor:
                                                      CupertinoColors
                                                          .systemGreen,
                                                  icon: CupertinoIcons
                                                      .circle_fill,
                                                  label: 'Record',
                                                ),
                                              ],
                                            ),
                                            endActionPane: ActionPane(
                                              motion: const BehindMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (_) {
                                                    if (widget.program !=
                                                        null) {
                                                      final idToRemove =
                                                          exercise.backendId ??
                                                          exercise.id
                                                              .toString();
                                                      final updatedExercises =
                                                          widget
                                                              .program!
                                                              .exercises
                                                              .where(
                                                                (pe) =>
                                                                    pe.exerciseId !=
                                                                    idToRemove,
                                                              )
                                                              .toList();
                                                      widget
                                                              .program!
                                                              .exercises =
                                                          updatedExercises;
                                                      ref
                                                          .read(
                                                            workoutProgramProvider
                                                                .notifier,
                                                          )
                                                          .updateProgram(
                                                            widget.program!,
                                                            widget
                                                                .program!
                                                                .backendId,
                                                          );
                                                    } else {
                                                      ref
                                                          .read(
                                                            workoutExerciseProvider(
                                                              false,
                                                            ).notifier,
                                                          )
                                                          .deleteExercise(
                                                            exercise,
                                                            exercise.backendId,
                                                          );
                                                    }
                                                  },
                                                  backgroundColor: isDark
                                                      ? Colors.red.shade900
                                                            .withValues(
                                                              alpha: 0.5,
                                                            )
                                                      : Colors.red.shade100,
                                                  foregroundColor:
                                                      CupertinoColors
                                                          .destructiveRed,
                                                  icon: CupertinoIcons.delete,
                                                  label: 'Delete',
                                                ),
                                              ],
                                            ),
                                            child: CupertinoListTile(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 12,
                                                  ),
                                              title: Text(
                                                exercise.name ?? 'Unnamed',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: isDark
                                                      ? CupertinoColors.white
                                                      : CupertinoColors.black,
                                                ),
                                              ),
                                              subtitle:
                                                  exercise.description != null
                                                  ? Text(
                                                      exercise.description!,
                                                      style: const TextStyle(
                                                        color: CupertinoColors
                                                            .systemGrey,
                                                      ),
                                                    )
                                                  : null,
                                              additionalInfo: Text(
                                                lastUsed != null
                                                    ? _formatDate(lastUsed)
                                                    : '',
                                                style: const TextStyle(
                                                  color: CupertinoColors
                                                      .systemGrey,
                                                ),
                                              ),
                                              trailing:
                                                  const CupertinoListTileChevron(),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        ExerciseDetailsScreen(
                                                          exercise: exercise,
                                                        ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                    // Add Exercises Button at bottom
                                    if (filtered.isNotEmpty)
                                      Divider(
                                        height: 1,
                                        color: isDark
                                            ? Colors.grey.shade800
                                            : Colors.grey.shade200,
                                      ),
                                    CupertinoButton(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            CupertinoIcons.add,
                                            color: primaryColor,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            widget.program != null
                                                ? 'Edit Exercises'
                                                : 'Add Exercises',
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () async {
                                        if (widget.program != null) {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  AddProgramScreen(
                                                    program: widget.program,
                                                  ),
                                            ),
                                          );
                                        } else {
                                          List<Exercise>? selected =
                                              await Navigator.push<
                                                List<Exercise>?
                                              >(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (_) => AddExerciseScreen(
                                                    initialSelectedIds:
                                                        exerciseList
                                                            .map(
                                                              (e) =>
                                                                  e.backendId ??
                                                                  '',
                                                            )
                                                            .where(
                                                              (id) =>
                                                                  id.isNotEmpty,
                                                            )
                                                            .toList(),
                                                  ),
                                                ),
                                              );

                                          if (selected != null) {
                                            final currentIds = exerciseList
                                                .map((e) => e.backendId)
                                                .where((id) => id != null)
                                                .toSet();

                                            final newIds = selected
                                                .map((e) => e.backendId)
                                                .where(
                                                  (id) =>
                                                      id != null &&
                                                      !currentIds.contains(id),
                                                )
                                                .cast<String>()
                                                .toList();

                                            if (newIds.isNotEmpty) {
                                              try {
                                                await ref
                                                    .read(
                                                      workoutSyncServiceProvider,
                                                    )
                                                    .localAddExercisesFromParent(
                                                      newIds,
                                                    );
                                                AppToast.success(
                                                  'Exercises added to your list',
                                                );
                                              } catch (e) {
                                                AppToast.error(
                                                  'Failed to add exercises: $e',
                                                );
                                              }
                                            }
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          );
                        }

                        return exercisesAsync.when(
                          data: buildList,
                          loading: () =>
                              const Center(child: CupertinoActivityIndicator()),
                          error: (err, stack) => Center(
                            child: Text(
                              'Error: $err',
                              style: const TextStyle(
                                color: CupertinoColors.destructiveRed,
                              ),
                            ),
                          ),
                        );
                      },
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

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 30) {
      return '${(diff.inDays / 30).floor()}mo ago';
    } else if (diff.inDays > 0) {
      return '${diff.inDays}d ago';
    } else {
      return 'Today';
    }
  }
}
