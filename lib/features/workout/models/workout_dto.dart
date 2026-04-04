// ----- Programs (/programs) -----

class ProgramDto {
  String? id;
  String? name;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ProgramExerciseDto>? exercises;

  ProgramDto({
    this.id,
    this.name,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.exercises,
  });

  factory ProgramDto.fromJson(Map<String, dynamic> json) => ProgramDto(
    id: json["id"],
    name: json["name"],
    userId: json["userId"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    exercises: json["exercises"] == null
        ? []
        : List<ProgramExerciseDto>.from(
            json["exercises"].map((x) => ProgramExerciseDto.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "userId": userId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "exercises": exercises == null
        ? []
        : List<dynamic>.from(exercises!.map((x) => x.toJson())),
  };
}

class ProgramExerciseDto {
  String? id;
  String? programId;
  String? exerciseId;
  int? order;
  ExerciseDto? exercise;

  ProgramExerciseDto({
    this.id,
    this.programId,
    this.exerciseId,
    this.order,
    this.exercise,
  });

  factory ProgramExerciseDto.fromJson(Map<String, dynamic> json) =>
      ProgramExerciseDto(
        id: json["id"],
        programId: json["programId"],
        exerciseId: json["exerciseId"],
        order: json["order"],
        exercise: json["exercise"] == null
            ? null
            : ExerciseDto.fromJson(json["exercise"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "programId": programId,
    "exerciseId": exerciseId,
    "order": order,
    "exercise": exercise?.toJson(),
  };
}

class CreateProgramDto {
  String? name;
  List<String>? exerciseIds;

  CreateProgramDto({this.name, this.exerciseIds});

  Map<String, dynamic> toJson() => {
    "name": name,
    "exerciseIds": exerciseIds == null
        ? []
        : List<dynamic>.from(exerciseIds!.map((x) => x)),
  };
}

class UpdateProgramDto {
  String? name;
  List<String>? exerciseIds;

  UpdateProgramDto({this.name, this.exerciseIds});

  Map<String, dynamic> toJson() => {
    "name": name,
    "exerciseIds": exerciseIds == null
        ? []
        : List<dynamic>.from(exerciseIds!.map((x) => x)),
  };
}

// ----- Exercises (/exercises) -----

class ExerciseCountDto {
  int? sets;

  ExerciseCountDto({this.sets});

  factory ExerciseCountDto.fromJson(Map<String, dynamic> json) =>
      ExerciseCountDto(sets: json["sets"]);

  Map<String, dynamic> toJson() => {"sets": sets};
}

class ExerciseDto {
  String? id;
  String? name;
  double? popularity;
  String? ownerId;
  String? oneRmFormula;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  ExerciseCountDto? count;

  ExerciseDto({
    this.id,
    this.name,
    this.popularity,
    this.ownerId,
    this.oneRmFormula,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.count,
  });

  factory ExerciseDto.fromJson(Map<String, dynamic> json) => ExerciseDto(
    id: json["id"],
    name: json["name"],
    popularity: json["popularity"]?.toDouble(),
    ownerId: json["ownerId"],
    oneRmFormula: json["oneRmFormula"],
    description: json["description"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    count: json["_count"] == null
        ? null
        : ExerciseCountDto.fromJson(json["_count"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "popularity": popularity,
    "ownerId": ownerId,
    "oneRmFormula": oneRmFormula,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "_count": count?.toJson(),
  };
}

class CreateExerciseDto {
  String? name;
  String? description;
  String? oneRmFormula;

  CreateExerciseDto({this.name, this.description, this.oneRmFormula});

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "oneRmFormula": oneRmFormula,
  };
}

class AddExercisesDto {
  List<String>? exerciseIds;

  AddExercisesDto({this.exerciseIds});

  Map<String, dynamic> toJson() => {
    "exerciseIds": exerciseIds == null
        ? []
        : List<dynamic>.from(exerciseIds!.map((x) => x)),
  };
}

class ExerciseDetailsDto {
  ExerciseDto? exercise;
  double? bestOneRm;
  ExerciseComparisonDto? comparison;
  PaginatedSetsDto? sets;

  ExerciseDetailsDto({
    this.exercise,
    this.bestOneRm,
    this.comparison,
    this.sets,
  });

  factory ExerciseDetailsDto.fromJson(Map<String, dynamic> json) =>
      ExerciseDetailsDto(
        exercise: json["exercise"] == null
            ? null
            : ExerciseDto.fromJson(json["exercise"]),
        bestOneRm: json["bestOneRm"]?.toDouble(),
        comparison: json["comparison"] == null
            ? null
            : ExerciseComparisonDto.fromJson(json["comparison"]),
        sets: json["sets"] == null
            ? null
            : PaginatedSetsDto.fromJson(json["sets"]),
      );

  Map<String, dynamic> toJson() => {
    "exercise": exercise?.toJson(),
    "bestOneRm": bestOneRm,
    "comparison": comparison?.toJson(),
    "sets": sets?.toJson(),
  };
}

class ExerciseComparisonDto {
  ExerciseComparisonDataDto? current;
  ExerciseComparisonDataDto? previous;
  ExerciseComparisonDeltaDto? delta;

  ExerciseComparisonDto({this.current, this.previous, this.delta});

  factory ExerciseComparisonDto.fromJson(Map<String, dynamic> json) =>
      ExerciseComparisonDto(
        current: json["current"] == null
            ? null
            : ExerciseComparisonDataDto.fromJson(json["current"]),
        previous: json["previous"] == null
            ? null
            : ExerciseComparisonDataDto.fromJson(json["previous"]),
        delta: json["delta"] == null
            ? null
            : ExerciseComparisonDeltaDto.fromJson(json["delta"]),
      );

  Map<String, dynamic> toJson() => {
    "current": current?.toJson(),
    "previous": previous?.toJson(),
    "delta": delta?.toJson(),
  };
}

class ExerciseComparisonDataDto {
  String? date;
  double? volume;
  double? maxWeight;

  ExerciseComparisonDataDto({this.date, this.volume, this.maxWeight});

  factory ExerciseComparisonDataDto.fromJson(Map<String, dynamic> json) =>
      ExerciseComparisonDataDto(
        date: json["date"],
        volume: json["volume"]?.toDouble(),
        maxWeight: json["maxWeight"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "date": date,
    "volume": volume,
    "maxWeight": maxWeight,
  };
}

class ExerciseComparisonDeltaDto {
  double? volume;
  double? maxWeight;

  ExerciseComparisonDeltaDto({this.volume, this.maxWeight});

  factory ExerciseComparisonDeltaDto.fromJson(Map<String, dynamic> json) =>
      ExerciseComparisonDeltaDto(
        volume: json["volume"]?.toDouble(),
        maxWeight: json["maxWeight"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {"volume": volume, "maxWeight": maxWeight};
}

class PaginatedSetsDto {
  List<WorkoutSetDto>? data;
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  PaginatedSetsDto({
    this.data,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory PaginatedSetsDto.fromJson(Map<String, dynamic> json) =>
      PaginatedSetsDto(
        data: json["data"] == null
            ? []
            : List<WorkoutSetDto>.from(
                json["data"].map((x) => WorkoutSetDto.fromJson(x)),
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

// ----- Sets (/sets) -----

class WorkoutSetDto {
  String? id;
  String? exerciseId;
  int? reps;
  double? weight;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;

  WorkoutSetDto({
    this.id,
    this.exerciseId,
    this.reps,
    this.weight,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkoutSetDto.fromJson(Map<String, dynamic> json) => WorkoutSetDto(
    id: json["id"],
    exerciseId: json["exerciseId"],
    reps: json["reps"],
    weight: json["weight"]?.toDouble(),
    comment: json["comment"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exerciseId": exerciseId,
    "reps": reps,
    "weight": weight,
    "comment": comment,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class CreateWorkoutSetDto {
  String? exerciseId;
  int? reps;
  double? weight;
  String? comment;

  CreateWorkoutSetDto({this.exerciseId, this.reps, this.weight, this.comment});

  Map<String, dynamic> toJson() => {
    "exerciseId": exerciseId,
    "reps": reps,
    "weight": weight,
    "comment": comment,
  };
}

class UpdateWorkoutSetDto {
  int? reps;
  double? weight;
  String? comment;

  UpdateWorkoutSetDto({this.reps, this.weight, this.comment});

  Map<String, dynamic> toJson() => {
    "reps": reps,
    "weight": weight,
    "comment": comment,
  };
}

class PaginatedExercisesDto {
  List<ExerciseDto>? data;
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  PaginatedExercisesDto({
    this.data,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory PaginatedExercisesDto.fromJson(Map<String, dynamic> json) {
    final meta = json["meta"] ?? {};
    return PaginatedExercisesDto(
      data: json["data"] == null
          ? []
          : List<ExerciseDto>.from(
              json["data"]!.map((x) => ExerciseDto.fromJson(x)),
            ),
      total: meta["total"] ?? json["total"],
      page: meta["currentPage"] ?? json["page"],
      limit: meta["perPage"] ?? json["limit"],
      totalPages: meta["lastPage"] ?? json["totalPages"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
      };
}
