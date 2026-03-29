import 'dart:async';
import 'package:calorie_tracker/core/services/local_data/isar_service.dart';

import '../repo/meal_repo.dart';

import 'package:calorie_tracker/features/meals/models/meal.dart';
import 'package:calorie_tracker/features/meals/models/meal_dto.dart';
import 'package:calorie_tracker/packages/packages.dart';
import 'package:isar/isar.dart';

typedef MealQuery = ({String? date, String? query});

final mealByIdProvider = FutureProvider.family<Meal?, int>((ref, id) async {
  final isar = IsarService.isar;
  return await isar.meals.get(id);
});

final mealProvider =
    AutoDisposeAsyncNotifierProviderFamily<MealNotifier, MealRepo, MealQuery>(
        MealNotifier.new);

class MealNotifier extends AutoDisposeFamilyAsyncNotifier<MealRepo, MealQuery> {
  final mealRepo = MealCloudRepo();
  @override
  FutureOr<MealRepo> build(arg) async {
    syncOnline();

    final sub = IsarService.isar.meals.watchLazy().listen((_) async {
      state = AsyncData(MealRepo(meals: await refresh()));
    });
    ref.onDispose(() => sub.cancel());

    return MealRepo(
      meals: await refresh(),
    );
  }

  Future syncOnline() async {
    final isar = IsarService.isar;
    await mealRepo.syncPendingMeals();
    if (arg.date != null) {
      _syncDailyMeals(isar, arg.date!);
    } else {
      _syncAllMeals(isar, arg.query);
    }
    state = AsyncData(
      MealRepo(
        meals: await refresh(),
      ),
    );
  }

  Future<List<Meal>> refresh() async {
    final isar = IsarService.isar;
    if (arg.date != null) {
      // --- DATE MODE: log entries for a specific day ---
      // 1. Return local meals for this day immediately
      final localMeals = await isar.meals
          .filter()
          .dateEqualTo(arg.date!)
          .not()
          .syncStatusEqualTo(SyncStatus.pendingDelete)
          .findAll();
      return localMeals;
    } else {
      // --- SUBMEAL / TEMPLATE MODE: templates & submeals with optional query ---
      // 1. Return local submeals immediately
      final localMeals = await isar.meals
          .filter()
          .showAsSubmealEqualTo(true)
          .optional(
            arg.query != null,
            (q) => q.nameContains(arg.query!, caseSensitive: false),
          )
          .findAll();
      return localMeals;
    }
  }

  refreshData() async {
    state = AsyncData(
      MealRepo(
        meals: await refresh(),
      ),
    );
  }

  Future<void> _syncDailyMeals(Isar isar, String date) async {
    try {
      final res = await mealRepo.getDailyMeals(date);
      if (!res.valid || res.data == null) return;

      final backendMeals = res.data!.meals ?? [];
      await _mergeIntoIsar(isar, backendMeals);

      // Re-query Isar after sync and emit fresh state
      final updated = await isar.meals
          .filter()
          .dateEqualTo(date)
          .not()
          .syncStatusEqualTo(SyncStatus.pendingDelete)
          .findAll();
      state = AsyncData(MealRepo(meals: updated));
    } catch (_) {
      // Offline — state already has local data, no-op
    }
  }

  Future<void> _syncAllMeals(Isar isar, String? query) async {
    try {
      final res = await mealRepo.getAllMeals(name: query);
      if (!res.valid || res.data == null) return;

      final backendMeals = res.data!.data ?? [];
      await _mergeIntoIsar(isar, backendMeals);

      // Re-query Isar after sync and emit fresh state
      final updated = await isar.meals
          .filter()
          .showAsSubmealEqualTo(true)
          .optional(
            query != null,
            (q) => q.nameContains(query!, caseSensitive: false),
          )
          .findAll();
      state = AsyncData(MealRepo(meals: updated));
    } catch (_) {
      // Offline — state already has local data, no-op
    }
  }

  Future<void> _mergeIntoIsar(Isar isar, List<MealResponseDto> meals) async {
    await isar.writeTxn(() async {
      for (final m in meals) {
        final backendId = m.id;
        if (backendId == null) continue;

        final existing = await isar.meals.getByBackendId(backendId);
        // Never overwrite a record that has unsynced local edits
        if (existing != null && existing.syncStatus != SyncStatus.synced) {
          continue;
        }

        final isarMeal = existing ?? Meal();
        isarMeal.backendId = backendId;
        isarMeal.name = m.name;
        isarMeal.type = m.type ?? 'LOGENTRY';
        isarMeal.date = m.consumedDate?.toIso8601String().split('T').first;
        isarMeal.caloriePerGram = m.caloriePerGram?.toDouble();
        isarMeal.weight = m.weight?.toDouble();
        isarMeal.syncStatus = SyncStatus.synced;
        isarMeal.showAsSubmeal = m.type == 'TEMPLATE';

        isarMeal.macros = Macros(
          protein: m.protienPerGram?.toDouble() ?? 0,
          fats: m.fatPerGram?.toDouble() ?? 0,
          carbs: m.carbsPerGram?.toDouble() ?? 0,
        );

        if (m.subMeals != null) {
          isarMeal.subMeals = m.subMeals!.map((smData) {
            final smInfo = smData.subMeal;
            return SubMeal()
              ..backendId = smData.subMealId
              ..name = smInfo?.name
              ..chosenWeight = smData.weightUsed?.toDouble()
              ..caloriesPerGram = smInfo?.caloriePerGram?.toDouble()
              ..macros = Macros(
                fats: smInfo?.fatPerGram?.toDouble() ?? 0,
                protein: smInfo?.protienPerGram?.toDouble() ?? 0,
                carbs: smInfo?.carbsPerGram?.toDouble() ?? 0,
              );
          }).toList();
        }

        await isar.meals.put(isarMeal);
      }
    });
  }

  Future<Meal> addMeal({
    required Meal meal,
  }) async {
    // 1. Persist locally right away with pendingCreate status
    meal.syncStatus = SyncStatus.pendingCreate;
    meal.backendId = 'local_${DateTime.now().microsecondsSinceEpoch}';
    meal.name ??= meal.subMeals.map((e) => e.name).join(' and ');
    final id = await mealRepo.saveMealLocally(meal);
    refreshData();

    return (await IsarService.isar.meals.get(id))!;
  }

  Future<void> deleteMeal({
    required Meal meal,
    required String? id,
  }) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.meals.delete(meal.id);
    });
    refreshData();
    if (id == null || id.startsWith('local_')) return;
    _syncDelete(meal, id);
  }

  Future<void> _syncDelete(Meal meal, String backendId) async {
    try {
      final res = await mealRepo.deleteMeal(backendId);
      if (res.valid) {
        AppToast.success('');
      } else if (!res.isNetworkError) {
        if (res.statusCode == 404) return;
        meal.syncStatus = SyncStatus.pendingDelete;
        await mealRepo.saveMealLocally(meal);
        refreshData();
        AppToast.error(res.message);
      }
    } catch (_) {}
  }

  Future<Meal?> updateMeal({
    required Meal meal,
    required String? id,
  }) async {
    // 1. Save updated meal locally right away with pendingUpdate status
    final isLocalId = id != null && id.startsWith('local_');
    meal.syncStatus =
        (id == null || isLocalId) ? SyncStatus.pendingCreate : SyncStatus.pendingUpdate;
    meal.backendId = id;
    final savedId = await mealRepo.saveMealLocally(meal);
    refreshData();

    return IsarService.isar.meals.get(savedId);
  }

  Future<List<Meal>> getMealByIds(List<int> ids) async {
    final data = await IsarService.isar.meals.getAll(ids);
    return data.nonNulls.toList();
  }
}

class MealRepo {
  List<Meal>? meals;

  String? get calories => meals
      ?.fold(
        0.0,
        (previousValue, element) =>
            double.parse(element.calories) + previousValue,
      )
      .toStringAsFixed(2);

  MealRepo({
    this.meals,
  });
}
