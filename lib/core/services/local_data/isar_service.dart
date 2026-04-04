import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../features/meals/models/meal.dart';
import '../../../features/workout/models/program.dart';
import '../../../features/workout/models/exercise.dart';
import '../../../features/workout/models/workout_set.dart';

class IsarService {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      MealSchema,
      ProgramSchema,
      ExerciseSchema,
      WorkoutSetSchema,
    ], directory: dir.path);
  }

  static Future<void> clearAll() async {
    await isar.writeTxn(() => isar.clear());
  }
}
