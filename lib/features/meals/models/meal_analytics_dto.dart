// To parse this JSON data, do
//
//     final mealAnalyticsDto = mealAnalyticsDtoFromJson(jsonString);

import 'dart:convert';

MealAnalyticsDto mealAnalyticsDtoFromJson(String str) =>
    MealAnalyticsDto.fromJson(json.decode(str));

String mealAnalyticsDtoToJson(MealAnalyticsDto data) =>
    json.encode(data.toJson());

class MealAnalyticsDto {
  String? period;
  Summary? summary;
  List<TopMeal>? topMeals;
  List<Trend>? trend;

  MealAnalyticsDto({this.period, this.summary, this.topMeals, this.trend});

  MealAnalyticsDto copyWith({
    String? period,
    Summary? summary,
    List<TopMeal>? topMeals,
    List<Trend>? trend,
  }) => MealAnalyticsDto(
    period: period ?? this.period,
    summary: summary ?? this.summary,
    topMeals: topMeals ?? this.topMeals,
    trend: trend ?? this.trend,
  );

  factory MealAnalyticsDto.fromJson(
    Map<String, dynamic> json,
  ) => MealAnalyticsDto(
    period: json["period"],
    summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
    topMeals: json["topMeals"] == null
        ? []
        : List<TopMeal>.from(json["topMeals"]!.map((x) => TopMeal.fromJson(x))),
    trend: json["trend"] == null
        ? []
        : List<Trend>.from(json["trend"]!.map((x) => Trend.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "period": period,
    "summary": summary?.toJson(),
    "topMeals": topMeals == null
        ? []
        : List<dynamic>.from(topMeals!.map((x) => x.toJson())),
    "trend": trend == null
        ? []
        : List<dynamic>.from(trend!.map((x) => x.toJson())),
  };
}

class Summary {
  int? totalMealsLogged;
  int? totalDaysTracked;
  int? averageDailyCalories;
  int? averageDailyProtein;
  DateTime? highestCalorieDay;

  Summary({
    this.totalMealsLogged,
    this.totalDaysTracked,
    this.averageDailyCalories,
    this.averageDailyProtein,
    this.highestCalorieDay,
  });

  Summary copyWith({
    int? totalMealsLogged,
    int? totalDaysTracked,
    int? averageDailyCalories,
    int? averageDailyProtein,
    DateTime? highestCalorieDay,
  }) => Summary(
    totalMealsLogged: totalMealsLogged ?? this.totalMealsLogged,
    totalDaysTracked: totalDaysTracked ?? this.totalDaysTracked,
    averageDailyCalories: averageDailyCalories ?? this.averageDailyCalories,
    averageDailyProtein: averageDailyProtein ?? this.averageDailyProtein,
    highestCalorieDay: highestCalorieDay ?? this.highestCalorieDay,
  );

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    totalMealsLogged: json["totalMealsLogged"],
    totalDaysTracked: json["totalDaysTracked"],
    averageDailyCalories: json["averageDailyCalories"],
    averageDailyProtein: json["averageDailyProtein"],
    highestCalorieDay: json["highestCalorieDay"] == null
        ? null
        : DateTime.parse(json["highestCalorieDay"]),
  );

  Map<String, dynamic> toJson() => {
    "totalMealsLogged": totalMealsLogged,
    "totalDaysTracked": totalDaysTracked,
    "averageDailyCalories": averageDailyCalories,
    "averageDailyProtein": averageDailyProtein,
    "highestCalorieDay":
        "${highestCalorieDay!.year.toString().padLeft(4, '0')}-${highestCalorieDay!.month.toString().padLeft(2, '0')}-${highestCalorieDay!.day.toString().padLeft(2, '0')}",
  };
}

class TopMeal {
  String? name;
  int? count;

  TopMeal({this.name, this.count});

  TopMeal copyWith({String? name, int? count}) =>
      TopMeal(name: name ?? this.name, count: count ?? this.count);

  factory TopMeal.fromJson(Map<String, dynamic> json) =>
      TopMeal(name: json["name"], count: json["count"]);

  Map<String, dynamic> toJson() => {"name": name, "count": count};
}

class Trend {
  DateTime? date;
  double? calories;
  double? protein;
  double? fat;
  double? carbs;

  Trend({this.date, this.calories, this.protein, this.fat, this.carbs});

  Trend copyWith({
    DateTime? date,
    double? calories,
    double? protein,
    double? fat,
    double? carbs,
  }) => Trend(
    date: date ?? this.date,
    calories: calories ?? this.calories,
    protein: protein ?? this.protein,
    fat: fat ?? this.fat,
    carbs: carbs ?? this.carbs,
  );

  factory Trend.fromJson(Map<String, dynamic> json) => Trend(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    calories: json["calories"]?.toDouble(),
    protein: json["protein"]?.toDouble(),
    fat: json["fat"]?.toDouble(),
    carbs: json["carbs"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "date":
        "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "calories": calories,
    "protein": protein,
    "fat": fat,
    "carbs": carbs,
  };
}
