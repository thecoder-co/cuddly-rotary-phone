import 'package:isar/isar.dart';

part 'meal.g.dart';

@collection
class Meal {
  Id id = Isar.autoIncrement;
  String? date;
  String? name;
  bool showAsSubmeal;
  double? caloriePerGram;
  double? weight;
  Macros? macros;

  @ignore
  bool withoutWeight = false;

  List<SubMeal> subMeals = []; // Embedded sub-meals

  String get calories {
    var calories = (((caloriePerGram ??
            subMeals.fold(
              0,
              (total, subMeal) =>
                  (total ?? 0) +
                  ((subMeal.caloriesPerGram ?? 1) *
                      (subMeal.chosenWeight ?? 1)),
            )) ??
        0));
    if (weight == null && showAsSubmeal) {
      calories *= 100;
    }
    return calories.toStringAsFixed(1);
  }

  double get caloriesUnit {
    var calories = (((caloriePerGram ??
            subMeals.fold(
              0,
              (total, subMeal) =>
                  (total ?? 0) +
                  ((subMeal.caloriesPerGram ?? 1) *
                      (subMeal.chosenWeight ?? 1)),
            )) ??
        0));
    return calories;
  }

  Meal({
    this.showAsSubmeal = false,
    this.date,
    this.name,
    this.caloriePerGram,
    this.weight,
    this.macros,
    this.subMeals = const [],
    this.withoutWeight = false,
  });

  Meal copyWith({
    String? date,
    String? name,
    bool? showAsSubmeal,
    double? caloriePerGram,
    double? weight,
    Macros? macros,
    List<SubMeal>? subMeals,
    bool? withoutWeight,
  }) {
    return Meal(
      date: date ?? this.date,
      name: name ?? this.name,
      showAsSubmeal: showAsSubmeal ?? this.showAsSubmeal,
      caloriePerGram: caloriePerGram ?? this.caloriePerGram,
      weight: weight ?? this.weight,
      macros: macros ?? this.macros,
      subMeals: subMeals ?? this.subMeals,
      withoutWeight: withoutWeight ?? this.withoutWeight,
    );
  }
}

@embedded
class SubMeal {
  String? name;
  double? chosenWeight;
  int? parentId;
  double? caloriesPerGram;
  Macros? macros;
}

@embedded
class Macros {
  double fats;
  double protein;
  double carbs;

  Macros({
    this.fats = 0,
    this.protein = 0,
    this.carbs = 0,
  });
  bool get isEmpty => fats == 0 && protein == 0 && carbs == 0;
  bool get isNotEmpty => !isEmpty;
}
