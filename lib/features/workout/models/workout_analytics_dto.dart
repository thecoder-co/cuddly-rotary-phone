class WorkoutAnalyticsDataDto {
  WorkoutAnalyticsAggregatesDto? aggregates;
  List<WorkoutTimeSeriesDto>? timeSeries;
  List<WorkoutOneRmTrendDto>? oneRmTrend;

  WorkoutAnalyticsDataDto({this.aggregates, this.timeSeries, this.oneRmTrend});

  factory WorkoutAnalyticsDataDto.fromJson(Map<String, dynamic> json) => WorkoutAnalyticsDataDto(
    aggregates: json["aggregates"] == null ? null : WorkoutAnalyticsAggregatesDto.fromJson(json["aggregates"]),
    timeSeries: json["timeSeries"] == null ? [] : List<WorkoutTimeSeriesDto>.from(json["timeSeries"].map((x) => WorkoutTimeSeriesDto.fromJson(x))),
    oneRmTrend: json["oneRmTrend"] == null ? [] : List<WorkoutOneRmTrendDto>.from(json["oneRmTrend"].map((x) => WorkoutOneRmTrendDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "aggregates": aggregates?.toJson(),
    "timeSeries": timeSeries == null ? [] : List<dynamic>.from(timeSeries!.map((x) => x.toJson())),
    "oneRmTrend": oneRmTrend == null ? [] : List<dynamic>.from(oneRmTrend!.map((x) => x.toJson())),
  };
}

class WorkoutAnalyticsAggregatesDto {
  double? totalVolume;
  double? maxWeight;
  int? totalReps;
  double? averageIntensity;
  int? totalSessions;

  WorkoutAnalyticsAggregatesDto({
    this.totalVolume,
    this.maxWeight,
    this.totalReps,
    this.averageIntensity,
    this.totalSessions,
  });

  factory WorkoutAnalyticsAggregatesDto.fromJson(Map<String, dynamic> json) => WorkoutAnalyticsAggregatesDto(
    totalVolume: json["totalVolume"]?.toDouble(),
    maxWeight: json["maxWeight"]?.toDouble(),
    totalReps: json["totalReps"],
    averageIntensity: json["averageIntensity"]?.toDouble(),
    totalSessions: json["totalSessions"],
  );

  Map<String, dynamic> toJson() => {
    "totalVolume": totalVolume,
    "maxWeight": maxWeight,
    "totalReps": totalReps,
    "averageIntensity": averageIntensity,
    "totalSessions": totalSessions,
  };
}

class WorkoutTimeSeriesDto {
  String? date;
  double? volume;
  double? maxWeight;
  int? totalReps;
  double? averageIntensity;

  WorkoutTimeSeriesDto({
    this.date,
    this.volume,
    this.maxWeight,
    this.totalReps,
    this.averageIntensity,
  });

  factory WorkoutTimeSeriesDto.fromJson(Map<String, dynamic> json) => WorkoutTimeSeriesDto(
    date: json["date"],
    volume: json["volume"]?.toDouble(),
    maxWeight: json["maxWeight"]?.toDouble(),
    totalReps: json["totalReps"],
    averageIntensity: json["averageIntensity"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "volume": volume,
    "maxWeight": maxWeight,
    "totalReps": totalReps,
    "averageIntensity": averageIntensity,
  };
}

class WorkoutOneRmTrendDto {
  String? date;
  double? oneRm;

  WorkoutOneRmTrendDto({this.date, this.oneRm});

  factory WorkoutOneRmTrendDto.fromJson(Map<String, dynamic> json) => WorkoutOneRmTrendDto(
    date: json["date"],
    oneRm: json["oneRm"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "oneRm": oneRm,
  };
}
