import 'dart:convert';

class MealComponentDto {
  String? subMealId;
  String? name;
  int? caloriePerGram;
  int? protienPerGram;
  int? fatPerGram;
  int? carbsPerGram;
  int? fibrePerGram;
  int? weightUsed;

  MealComponentDto({
    this.subMealId,
    this.name,
    this.caloriePerGram,
    this.protienPerGram,
    this.fatPerGram,
    this.carbsPerGram,
    this.fibrePerGram,
    this.weightUsed,
  });

  MealComponentDto copyWith({
    String? subMealId,
    String? name,
    int? caloriePerGram,
    int? protienPerGram,
    int? fatPerGram,
    int? carbsPerGram,
    int? fibrePerGram,
    int? weightUsed,
  }) => MealComponentDto(
    subMealId: subMealId ?? this.subMealId,
    name: name ?? this.name,
    caloriePerGram: caloriePerGram ?? this.caloriePerGram,
    protienPerGram: protienPerGram ?? this.protienPerGram,
    fatPerGram: fatPerGram ?? this.fatPerGram,
    carbsPerGram: carbsPerGram ?? this.carbsPerGram,
    fibrePerGram: fibrePerGram ?? this.fibrePerGram,
    weightUsed: weightUsed ?? this.weightUsed,
  );

  factory MealComponentDto.fromJson(Map<String, dynamic> json) =>
      MealComponentDto(
        subMealId: json["subMealId"],
        name: json["name"],
        caloriePerGram: json["caloriePerGram"],
        protienPerGram: json["protienPerGram"],
        fatPerGram: json["fatPerGram"],
        carbsPerGram: json["carbsPerGram"],
        fibrePerGram: json["fibrePerGram"],
        weightUsed: json["weightUsed"],
      );

  Map<String, dynamic> toJson() => {
    "subMealId": subMealId,
    "name": name,
    "caloriePerGram": caloriePerGram,
    "protienPerGram": protienPerGram,
    "fatPerGram": fatPerGram,
    "carbsPerGram": carbsPerGram,
    "fibrePerGram": fibrePerGram,
    "weightUsed": weightUsed,
  };
}

class CreateMealDto {
  final String? name;
  final String? description;
  final String? type; // 'TEMPLATE' or 'LOGENTRY'
  final bool? saveAsTemplate;
  final String? consumedDate;
  final double? caloriePerGram;
  final double? protienPerGram;
  final double? fatPerGram;
  final double? carbsPerGram;
  final double? fibrePerGram;
  final double? weight;
  final List<MealComponentDto>? components;
  final String? originalMealId;
  final String? image;

  CreateMealDto({
    this.name,
    this.description,
    this.type,
    this.saveAsTemplate,
    this.consumedDate,
    this.caloriePerGram,
    this.protienPerGram,
    this.fatPerGram,
    this.carbsPerGram,
    this.fibrePerGram,
    this.weight,
    this.components,
    this.originalMealId,
    this.image,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'type': type,
    'saveAsTemplate': saveAsTemplate,
    'consumedDate': consumedDate,
    'caloriePerGram': caloriePerGram,
    'protienPerGram': protienPerGram,
    'fatPerGram': fatPerGram,
    'carbsPerGram': carbsPerGram,
    'fibrePerGram': fibrePerGram,
    'weight': weight,
    'components': components?.map((e) => e.toJson()).toList(),
    'originalMealId': originalMealId,
    'image': image,
  };
}

class UpdateMealDto extends CreateMealDto {
  UpdateMealDto({
    super.name,
    super.description,
    super.type,
    super.saveAsTemplate,
    super.consumedDate,
    super.caloriePerGram,
    super.protienPerGram,
    super.fatPerGram,
    super.carbsPerGram,
    super.fibrePerGram,
    super.weight,
    super.components,
    super.originalMealId,
    super.image,
  });
}

// To parse this JSON data, do
//
//     final mealResponseDto = mealResponseDtoFromJson(jsonString);

MealResponseDto mealResponseDtoFromJson(String str) =>
    MealResponseDto.fromJson(json.decode(str));

String mealResponseDtoToJson(MealResponseDto data) =>
    json.encode(data.toJson());

class MealResponseDto {
  String? id;
  String? creatorId;
  String? name;
  String? slug;
  String? description;
  String? type;
  DateTime? consumedDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? caloriePerGram;
  num? protienPerGram;
  num? fatPerGram;
  num? carbsPerGram;
  num? fibrePerGram;
  num? weight;
  List<BackendSubMeal>? subMeals;
  num? calories;
  num? protein;
  num? fat;
  num? carbs;
  num? fibre;
  String? image;

  MealResponseDto({
    this.id,
    this.creatorId,
    this.name,
    this.slug,
    this.description,
    this.type,
    this.consumedDate,
    this.createdAt,
    this.updatedAt,
    this.caloriePerGram,
    this.protienPerGram,
    this.fatPerGram,
    this.carbsPerGram,
    this.fibrePerGram,
    this.weight,
    this.subMeals,
    this.calories,
    this.protein,
    this.fat,
    this.carbs,
    this.fibre,
    this.image,
  });

  MealResponseDto copyWith({
    String? id,
    String? creatorId,
    String? name,
    String? slug,
    String? description,
    String? type,
    DateTime? consumedDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    num? caloriePerGram,
    num? protienPerGram,
    num? fatPerGram,
    num? carbsPerGram,
    num? fibrePerGram,
    num? weight,
    List<BackendSubMeal>? subMeals,
    num? calories,
    num? protein,
    num? fat,
    num? carbs,
    num? fibre,
    String? image,
  }) => MealResponseDto(
    id: id ?? this.id,
    creatorId: creatorId ?? this.creatorId,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    description: description ?? this.description,
    type: type ?? this.type,
    consumedDate: consumedDate ?? this.consumedDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    caloriePerGram: caloriePerGram ?? this.caloriePerGram,
    protienPerGram: protienPerGram ?? this.protienPerGram,
    fatPerGram: fatPerGram ?? this.fatPerGram,
    carbsPerGram: carbsPerGram ?? this.carbsPerGram,
    fibrePerGram: fibrePerGram ?? this.fibrePerGram,
    weight: weight ?? this.weight,
    subMeals: subMeals ?? this.subMeals,
    calories: calories ?? this.calories,
    protein: protein ?? this.protein,
    fat: fat ?? this.fat,
    carbs: carbs ?? this.carbs,
    fibre: fibre ?? this.fibre,
    image: image ?? this.image,
  );

  factory MealResponseDto.fromJson(Map<String, dynamic> json) =>
      MealResponseDto(
        id: json["id"],
        creatorId: json["creatorId"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        type: json["type"],
        consumedDate: json["consumedDate"] == null
            ? null
            : DateTime.parse(json["consumedDate"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        caloriePerGram: json["caloriePerGram"]?.toDouble(),
        protienPerGram: json["protienPerGram"]?.toDouble(),
        fatPerGram: json["fatPerGram"]?.toDouble(),
        carbsPerGram: json["carbsPerGram"]?.toDouble(),
        fibrePerGram: json["fibrePerGram"],
        weight: json["weight"],
        subMeals: json["subMeals"] == null
            ? []
            : List<BackendSubMeal>.from(
                json["subMeals"]!.map((x) => BackendSubMeal.fromJson(x)),
              ),
        calories: json["calories"],
        protein: json["protein"],
        fat: json["fat"],
        carbs: json["carbs"],
        fibre: json["fibre"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "creatorId": creatorId,
    "name": name,
    "slug": slug,
    "description": description,
    "type": type,
    "consumedDate": consumedDate,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "caloriePerGram": caloriePerGram,
    "protienPerGram": protienPerGram,
    "fatPerGram": fatPerGram,
    "carbsPerGram": carbsPerGram,
    "fibrePerGram": fibrePerGram,
    "weight": weight,
    "subMeals": subMeals == null
        ? []
        : List<dynamic>.from(subMeals!.map((x) => x)),
    "calories": calories,
    "protein": protein,
    "fat": fat,
    "carbs": carbs,
    "fibre": fibre,
    "image": image,
  };
}

AllMealResponseDto allMealResponseDtoFromJson(String str) =>
    AllMealResponseDto.fromJson(json.decode(str));

String allMealResponseDtoToJson(AllMealResponseDto data) =>
    json.encode(data.toJson());

class AllMealResponseDto {
  List<MealResponseDto>? data;
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  AllMealResponseDto({
    this.data,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  AllMealResponseDto copyWith({
    List<MealResponseDto>? data,
    int? total,
    int? page,
    int? limit,
    int? totalPages,
  }) => AllMealResponseDto(
    data: data ?? this.data,
    total: total ?? this.total,
    page: page ?? this.page,
    limit: limit ?? this.limit,
    totalPages: totalPages ?? this.totalPages,
  );

  factory AllMealResponseDto.fromJson(Map<String, dynamic> json) =>
      AllMealResponseDto(
        data: json["data"] == null
            ? []
            : List<MealResponseDto>.from(
                json["data"]!.map((x) => MealResponseDto.fromJson(x)),
              ),
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "total": total,
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
  };
}

class BackendSubMeal {
  String? id;
  int? weightUsed;
  String? parentMealId;
  String? subMealId;
  MealResponseDto? subMeal;

  BackendSubMeal({
    this.id,
    this.weightUsed,
    this.parentMealId,
    this.subMealId,
    this.subMeal,
  });

  BackendSubMeal copyWith({
    String? id,
    int? weightUsed,
    String? parentMealId,
    String? subMealId,
    MealResponseDto? subMeal,
  }) => BackendSubMeal(
    id: id ?? this.id,
    weightUsed: weightUsed ?? this.weightUsed,
    parentMealId: parentMealId ?? this.parentMealId,
    subMealId: subMealId ?? this.subMealId,
    subMeal: subMeal ?? this.subMeal,
  );

  factory BackendSubMeal.fromJson(Map<String, dynamic> json) => BackendSubMeal(
    id: json["id"],
    weightUsed: json["weightUsed"],
    parentMealId: json["parentMealId"],
    subMealId: json["subMealId"],
    subMeal: json["subMeal"] == null
        ? null
        : MealResponseDto.fromJson(json["subMeal"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "weightUsed": weightUsed,
    "parentMealId": parentMealId,
    "subMealId": subMealId,
    "subMeal": subMeal?.toJson(),
  };
}

DailyMealDto dailyMealDtoFromJson(String str) =>
    DailyMealDto.fromJson(json.decode(str));

String dailyMealDtoToJson(DailyMealDto data) => json.encode(data.toJson());

class DailyMealDto {
  Summary? summary;
  List<MealResponseDto>? meals;

  DailyMealDto({this.summary, this.meals});

  DailyMealDto copyWith({Summary? summary, List<MealResponseDto>? meals}) =>
      DailyMealDto(
        summary: summary ?? this.summary,
        meals: meals ?? this.meals,
      );

  factory DailyMealDto.fromJson(Map<String, dynamic> json) => DailyMealDto(
    summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
    meals: json["meals"] == null
        ? []
        : List<MealResponseDto>.from(
            json["meals"]!.map((x) => MealResponseDto.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "summary": summary?.toJson(),
    "meals": meals == null
        ? []
        : List<dynamic>.from(meals!.map((x) => x.toJson())),
  };
}

class Summary {
  double? calories;
  int? protein;
  int? fat;
  int? carbs;
  int? fibre;

  Summary({this.calories, this.protein, this.fat, this.carbs, this.fibre});

  Summary copyWith({
    double? calories,
    int? protein,
    int? fat,
    int? carbs,
    int? fibre,
  }) => Summary(
    calories: calories ?? this.calories,
    protein: protein ?? this.protein,
    fat: fat ?? this.fat,
    carbs: carbs ?? this.carbs,
    fibre: fibre ?? this.fibre,
  );

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    calories: json["calories"]?.toDouble(),
    protein: json["protein"],
    fat: json["fat"],
    carbs: json["carbs"],
    fibre: json["fibre"],
  );

  Map<String, dynamic> toJson() => {
    "calories": calories,
    "protein": protein,
    "fat": fat,
    "carbs": carbs,
    "fibre": fibre,
  };
}
