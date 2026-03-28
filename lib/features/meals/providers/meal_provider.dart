import 'dart:async';

import 'package:calorie_tracker/features/meals/models/meal.dart';
import 'package:calorie_tracker/packages/packages.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

typedef MealQuery = ({String? date, String? query});

final mealByIdProvider = FutureProvider.family<Meal?, int>((ref, id) async {
  final isar = await ref.watch(isarProvider.future);
  return await isar.meals.get(id);
});

final isarProvider = FutureProvider<Isar>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [MealSchema],
    directory: dir.path,
  );
  return isar;
});

final mealProvider =
    AutoDisposeAsyncNotifierProviderFamily<MealNotifier, MealRepo, MealQuery>(
        MealNotifier.new);

class MealNotifier extends AutoDisposeFamilyAsyncNotifier<MealRepo, MealQuery> {
  @override
  FutureOr<MealRepo> build(arg) async {
    final isar = await ref.read(isarProvider.future);
    final meals = await isar.meals
        .filter()
        .optional(arg.date != null, (q) => q.dateEqualTo(arg.date!))
        //if date is null
        .optional(arg.date == null, (q) => q.showAsSubmealEqualTo(true))
        .optional(
          arg.query != null,
          (q) => q.nameContains(arg.query!, caseSensitive: false),
        )
        .findAll();
    return MealRepo(meals: meals);
  }

  Future<Meal> addMeal({
    required Meal meal,
  }) async {
    if (!ref.read(isarProvider).hasValue) {
      await Future.doWhile(() async {
        await Future.delayed(
          const Duration(milliseconds: 10),
        ); // Small delay to avoid blocking
        return !state.hasValue;
      });
    }
    late final int id;
    await ref.read(isarProvider).value!.writeTxn(() async {
      id = await ref.read(isarProvider).value!.meals.put(meal);
    });
    ref.invalidate(mealProvider);
    return (await ref.read(isarProvider).value!.meals.get(id))!;
  }

  Future<List<Meal>> getMealByIds(List<int> ids) async {
    if (!state.hasValue) {
      await Future.doWhile(() async {
        await Future.delayed(
          const Duration(milliseconds: 10),
        ); // Small delay to avoid blocking
        return !state.hasValue;
      });
    }
    final data = await ref.read(isarProvider).value!.meals.getAll(ids);
    return data.nonNulls.toList();
  }

  Future<bool> deleteMeal(int id) async {
    if (!state.hasValue) {
      await Future.doWhile(() async {
        await Future.delayed(
          const Duration(milliseconds: 10),
        ); // Small delay to avoid blocking
        return !state.hasValue;
      });
    }
    late final bool res;
    await ref.read(isarProvider).value!.writeTxn(() async {
      res = await ref.read(isarProvider).value!.meals.delete(id);
    });
    ref.invalidate(mealProvider);

    return res;
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
