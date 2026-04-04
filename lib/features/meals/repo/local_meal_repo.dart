import 'package:calorie_tracker/core/services/local_data/isar_service.dart';
import 'package:calorie_tracker/features/meals/models/meal.dart';
import 'package:isar_community/isar.dart';

class LocalMealRepo {
  final Isar isar;

  LocalMealRepo({Isar? isarInstance}) : isar = isarInstance ?? IsarService.isar;

  Future<int> saveMeal(Meal meal) async {
    return await isar.writeTxn(() async {
      return await isar.meals.put(meal);
    });
  }

  Future<void> deleteMeal(int id) async {
    await isar.writeTxn(() async {
      await isar.meals.delete(id);
    });
  }

  Future<Meal?> getMeal(dynamic id) async {
    if (id is String) {
      return await isar.meals.getByBackendId(id);
    }
    return await isar.meals.get(id);
  }

  Future<List<Meal>> getMealByIds(List<int> ids) async {
    final data = await isar.meals.getAll(ids);
    return data.nonNulls.toList();
  }

  Future<Meal?> getByBackendId(String backendId) async {
    return await isar.meals.getByBackendId(backendId);
  }

  Future<List<Meal>> getPendingMeals() async {
    return await isar.meals
        .filter()
        .syncStatusEqualTo(SyncStatus.pendingCreate)
        .or()
        .syncStatusEqualTo(SyncStatus.pendingUpdate)
        .or()
        .syncStatusEqualTo(SyncStatus.pendingDelete)
        .findAll();
  }

  Stream<List<Meal>> watchMeals({String? date, String? query}) async* {
    final stream = isar.meals.watchLazy(fireImmediately: true);
    await for (final _ in stream) {
      if (date != null) {
        yield await isar.meals
            .filter()
            .dateEqualTo(date)
            .not()
            .syncStatusEqualTo(SyncStatus.pendingDelete)
            .findAll();
      } else {
        yield await isar.meals
            .filter()
            .showAsSubmealEqualTo(true)
            .optional(
              query != null,
              (q) => q.nameContains(query!, caseSensitive: false),
            )
            .findAll();
      }
    }
  }
}
