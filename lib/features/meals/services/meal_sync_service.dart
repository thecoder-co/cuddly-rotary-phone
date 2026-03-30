import 'package:calorie_tracker/features/meals/models/meal.dart';
import 'package:calorie_tracker/features/meals/models/meal_dto.dart';
import 'package:calorie_tracker/features/meals/repo/local_meal_repo.dart';
import 'package:calorie_tracker/features/meals/repo/meal_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer';

final mealSyncServiceProvider = Provider((ref) {
  return MealSyncService(
    localRepo: LocalMealRepo(),
    cloudRepo: MealCloudRepo(),
  );
});

class MealSyncService {
  final LocalMealRepo localRepo;
  final MealCloudRepo cloudRepo;

  MealSyncService({required this.localRepo, required this.cloudRepo});

  Future<void> syncPendingMeals() async {
    final pendingMeals = await localRepo.getPendingMeals();
    for (final meal in pendingMeals) {
      try {
        if (meal.syncStatus == SyncStatus.pendingCreate) {
          final dto = CreateMealDto(
            name: meal.name,
            type: meal.type,
            consumedDate: meal.date,
            caloriePerGram: meal.caloriePerGram,
            protienPerGram: meal.macros?.protein,
            fatPerGram: meal.macros?.fats,
            carbsPerGram: meal.macros?.carbs,
            weight: meal.weight,
            components: meal.subMeals
                .map((e) {
                  final isLocal = e.backendId == null || e.backendId!.startsWith('local');
                  return MealComponentDto(
                    subMealId: isLocal ? null : e.backendId,
                    name: isLocal ? e.name : null,
                    caloriePerGram: isLocal ? e.caloriesPerGram?.toInt() : null,
                    protienPerGram: isLocal ? e.macros?.protein.toInt() : null,
                    fatPerGram: isLocal ? e.macros?.fats.toInt() : null,
                    carbsPerGram: isLocal ? e.macros?.carbs.toInt() : null,
                    weightUsed: e.chosenWeight?.toInt(),
                  );
                })
                .toList(),
          );
          final res = await cloudRepo.createMeal(dto);
          if (res.valid) {
            await localRepo.isar.writeTxn(() async {
              meal.syncStatus = SyncStatus.synced;
              if (res.data?.id != null) {
                meal.backendId = res.data!.id;
              }
              await localRepo.isar.meals.put(meal);
            });
          }
        } else if (meal.syncStatus == SyncStatus.pendingUpdate) {
          final dto = UpdateMealDto(
            name: meal.name,
            type: meal.type,
            consumedDate: meal.date,
            caloriePerGram: meal.caloriePerGram,
            protienPerGram: meal.macros?.protein,
            fatPerGram: meal.macros?.fats,
            carbsPerGram: meal.macros?.carbs,
            weight: meal.weight,
            components: meal.subMeals
                .map((e) {
                  final isLocal = e.backendId == null || e.backendId!.startsWith('local');
                  return MealComponentDto(
                    subMealId: isLocal ? null : e.backendId,
                    name: isLocal ? e.name : null,
                    caloriePerGram: isLocal ? e.caloriesPerGram?.toInt() : null,
                    protienPerGram: isLocal ? e.macros?.protein.toInt() : null,
                    fatPerGram: isLocal ? e.macros?.fats.toInt() : null,
                    carbsPerGram: isLocal ? e.macros?.carbs.toInt() : null,
                    weightUsed: e.chosenWeight?.toInt(),
                  );
                })
                .toList(),
          );
          final res = await cloudRepo.updateMeal(meal.backendId!, dto);
          if (res.valid) {
            await localRepo.isar.writeTxn(() async {
              meal.syncStatus = SyncStatus.synced;
              await localRepo.isar.meals.put(meal);
            });
          }
        } else if (meal.syncStatus == SyncStatus.pendingDelete) {
          final res = await cloudRepo.deleteMeal(meal.backendId!);
          if (res.valid) {
            await localRepo.deleteMeal(meal.id);
          } else if (!res.isNetworkError && res.statusCode == 404) {
             // Already deleted on backend
            await localRepo.deleteMeal(meal.id);
          }
        }
      } catch (e) {
        log('Error syncing meal ${meal.id}: $e');
      }
    }
  }

  Future<void> syncDailyMeals(String date) async {
    try {
      final res = await cloudRepo.getDailyMeals(date);
      if (!res.valid || res.data == null) return;
      final backendMeals = res.data!.meals ?? [];
      await _mergeIntoIsar(backendMeals);
    } catch (_) {}
  }

  Future<void> syncAllMeals(String? query) async {
    try {
      final res = await cloudRepo.getAllMeals(name: query);
      if (!res.valid || res.data == null) return;
      final backendMeals = res.data!.data ?? [];
      await _mergeIntoIsar(backendMeals);
    } catch (_) {}
  }

  Future<void> _mergeIntoIsar(List<MealResponseDto> meals) async {
    final isar = localRepo.isar;
    await isar.writeTxn(() async {
      for (final m in meals) {
        final backendId = m.id;
        if (backendId == null) continue;

        final existing = await isar.meals.getByBackendId(backendId);
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
}
