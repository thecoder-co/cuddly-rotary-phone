import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../features/meals/models/meal.dart';

class IsarService {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [MealSchema],
      directory: dir.path,
    );
  }
}
