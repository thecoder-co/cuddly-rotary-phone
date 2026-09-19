import 'dart:async';
import 'package:calorie_tracker/features/meals/repo/local_meal_repo.dart';
import 'package:calorie_tracker/features/meals/services/meal_sync_service.dart';
import 'package:calorie_tracker/core/providers/account_scope_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:calorie_tracker/features/meals/models/meal.dart';

typedef MealQuery = ({String? date, String? query});

final localMealRepoProvider = Provider((ref) {
  ref.watch(accountScopeProvider);
  return LocalMealRepo();
});

final mealByIdProvider = FutureProvider.family<Meal?, dynamic>((ref, id) async {
  return await ref.watch(localMealRepoProvider).getMeal(id);
});

final isarMealsStreamProvider = StreamProvider.autoDispose
    .family<List<Meal>, MealQuery>((ref, arg) {
      final localRepo = ref.watch(localMealRepoProvider);
      final syncService = ref.read(mealSyncServiceProvider);

      // Fire and forget sync operation
      Future(() async {
        await syncService.syncPendingMeals();
        if (arg.date != null) {
          await syncService.syncDailyMeals(arg.date!);
        } else {
          await syncService.syncAllMeals(arg.query);
        }
      });

      return localRepo.watchMeals(date: arg.date, query: arg.query);
    });

final mealProvider = AsyncNotifierProvider.autoDispose
    .family<MealNotifier, MealRepo, MealQuery>(MealNotifier.new);

class MealNotifier extends AsyncNotifier<MealRepo> {
  final MealQuery arg;

  MealNotifier(this.arg);

  @override
  FutureOr<MealRepo> build() async {
    // Listens seamlessly to the streamed updates natively.
    final meals = await ref.watch(isarMealsStreamProvider(arg).future);
    return MealRepo(meals: meals);
  }

  Future<Meal> addMeal({required Meal meal}) async {
    meal.syncStatus = SyncStatus.pendingCreate;
    meal.backendId = 'local_${DateTime.now().microsecondsSinceEpoch}';
    meal.name ??= meal.subMeals.map((e) => e.name).join(' and ');

    final localRepo = ref.read(localMealRepoProvider);
    final id = await localRepo.saveMeal(meal);

    // Background sync (fire and forget)
    ref.read(mealSyncServiceProvider).syncPendingMeals();

    return (await localRepo.getMeal(id))!;
  }

  Future<Meal?> updateMeal({required Meal meal, required String? id}) async {
    final isLocalId = id != null && id.startsWith('local_');
    meal.syncStatus = (id == null || isLocalId)
        ? SyncStatus.pendingCreate
        : SyncStatus.pendingUpdate;
    meal.backendId = id;

    final localRepo = ref.read(localMealRepoProvider);
    final savedId = await localRepo.saveMeal(meal);

    // Background sync (fire and forget)
    ref.read(mealSyncServiceProvider).syncPendingMeals();

    return localRepo.getMeal(savedId);
  }

  Future<void> deleteMeal({required Meal meal, required String? id}) async {
    final localRepo = ref.read(localMealRepoProvider);

    if (id == null || id.startsWith('local_')) {
      await localRepo.deleteMeal(meal.id);
      return;
    }

    // Mark as pendingDelete and resave so the syncService can pick it up
    meal.syncStatus = SyncStatus.pendingDelete;
    await localRepo.saveMeal(meal);

    // Background sync (fire and forget)
    ref.read(mealSyncServiceProvider).syncPendingMeals();
  }

  Future<List<Meal>> getMealByIds(List<int> ids) async {
    return ref.read(localMealRepoProvider).getMealByIds(ids);
  }
}

class MealRepo {
  List<Meal>? meals;

  double get doubleCalories =>
      meals?.fold(
        0.0,
        (previousValue, element) =>
            double.parse(element.calories) + previousValue!,
      ) ??
      0.0;

  String? get calories => doubleCalories.toStringAsFixed(2);

  MealRepo({this.meals});
}
