import 'package:isar_community/isar.dart';

part 'meal.g.dart';

enum SyncStatus {
  synced,
  pendingCreate,
  pendingUpdate,
  pendingDelete,
  pendingAddFromParent,
}

@collection
class Meal {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? backendId;

  @enumerated
  SyncStatus syncStatus = SyncStatus.pendingCreate; // Offline sync
  String? syncError;
  String type = 'LOGENTRY';

  String? date;
  String? name;
  bool showAsSubmeal;
  double? caloriePerGram;
  double? weight;
  Macros? macros;

  @ignore
  bool withoutWeight = false;

  List<SubMeal> subMeals = []; // Embedded sub-meals

  double get totalSubMealWeight => subMeals.fold<double>(
    0.0,
    (total, sm) => total + (sm.chosenWeight ?? 0.0),
  );

  double get inferredCaloriePerGram {
    if (subMeals.isEmpty) return 0.0;
    final totalCals = subMeals.fold<double>(
      0.0,
      (total, sm) =>
          total + ((sm.caloriesPerGram ?? 0.0) * (sm.chosenWeight ?? 0.0)),
    );
    final w = totalSubMealWeight;
    return w > 0 ? (totalCals / w) : 0.0;
  }

  double get inferredProteinPerGram {
    if (subMeals.isEmpty) return 0.0;
    final total = subMeals.fold<double>(
      0.0,
      (total, sm) =>
          total + ((sm.macros?.protein ?? 0.0) * (sm.chosenWeight ?? 0.0)),
    );
    final w = totalSubMealWeight;
    return w > 0 ? (total / w) : 0.0;
  }

  double get inferredFatPerGram {
    if (subMeals.isEmpty) return 0.0;
    final total = subMeals.fold<double>(
      0.0,
      (total, sm) =>
          total + ((sm.macros?.fats ?? 0.0) * (sm.chosenWeight ?? 0.0)),
    );
    final w = totalSubMealWeight;
    return w > 0 ? (total / w) : 0.0;
  }

  double get inferredCarbsPerGram {
    if (subMeals.isEmpty) return 0.0;
    final total = subMeals.fold<double>(
      0.0,
      (total, sm) =>
          total + ((sm.macros?.carbs ?? 0.0) * (sm.chosenWeight ?? 0.0)),
    );
    final w = totalSubMealWeight;
    return w > 0 ? (total / w) : 0.0;
  }

  double get actualCaloriePerGram => caloriePerGram ?? inferredCaloriePerGram;
  double get actualProteinPerGram => macros?.protein ?? inferredProteinPerGram;
  double get actualFatPerGram => macros?.fats ?? inferredFatPerGram;
  double get actualCarbsPerGram => macros?.carbs ?? inferredCarbsPerGram;

  double get resolvedWeight =>
      weight ??
      (totalSubMealWeight > 0
          ? totalSubMealWeight
          : (showAsSubmeal ? 100.0 : 0.0));

  String get calories =>
      (actualCaloriePerGram * resolvedWeight).toStringAsFixed(1);
  double get caloriesUnit => actualCaloriePerGram * resolvedWeight;

  Meal({
    this.showAsSubmeal = false,
    this.date,
    this.name,
    this.caloriePerGram,
    this.weight,
    this.macros,
    this.subMeals = const [],
    this.withoutWeight = false,
    this.backendId,
    this.syncStatus = SyncStatus.pendingCreate,
    this.type = 'LOGENTRY',
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
    String? backendId,
    SyncStatus? syncStatus,
    String? type,
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
      backendId: backendId ?? this.backendId,
      syncStatus: syncStatus ?? this.syncStatus,
      type: type ?? this.type,
    );
  }
}

@embedded
class SubMeal {
  String? backendId; // Match backend UUID
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

  Macros({this.fats = 0, this.protein = 0, this.carbs = 0});
  bool get isEmpty => fats == 0 && protein == 0 && carbs == 0;
  bool get isNotEmpty => !isEmpty;
}
