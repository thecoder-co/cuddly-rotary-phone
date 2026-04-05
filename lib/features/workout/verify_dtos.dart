import 'package:calorie_tracker/features/workout/models/workout_dto.dart';
import 'package:calorie_tracker/features/workout/models/workout_analytics_dto.dart';

void main() {
  print('--- Verifying DTO Serialization ---');

  // Test Analytics DTO
  final analyticsJson = {
    "aggregates": {
      "totalVolume": 14500.5,
      "maxWeight": 315,
      "totalReps": 450,
      "averageIntensity": 32.22,
      "totalSessions": 12,
    },
    "timeSeries": [
      {
        "date": "2026-03-29",
        "volume": 3150,
        "maxWeight": 315,
        "totalReps": 10,
        "averageIntensity": 315,
      },
    ],
    "oneRmTrend": [
      {"date": "2026-03-29", "oneRm": 346.5},
    ],
  };

  final analyticsDto = WorkoutAnalyticsDataDto.fromJson(analyticsJson);
  print(
    'Analytics aggregates totalVolume: ${analyticsDto.aggregates?.totalVolume}',
  );
  print('Analytics timeSeries date: ${analyticsDto.timeSeries?.first.date}');
  print('Analytics oneRmTrend oneRm: ${analyticsDto.oneRmTrend?.first.oneRm}');
  assert(analyticsDto.aggregates?.totalVolume == 14500.5);

  // Test Exercise Details DTO
  final detailsJson = {
    "exercise": {
      "id": "uuid",
      "name": "Bench Press",
      "popularity": 0.45,
      "ownerId": "uuid",
      "oneRmFormula": "Epley",
      "description": "Barbell bench press",
      "createdAt": "2026-03-29T10:00:00.000Z",
      "updatedAt": "2026-03-29T10:00:00.000Z",
      "_count": {"sets": 120},
    },
    "bestOneRm": 125.5,
    "comparison": {
      "current": {"date": "2026-03-29", "volume": 1500, "maxWeight": 100},
      "previous": {"date": "2026-03-22", "volume": 1400, "maxWeight": 95},
      "delta": {"volume": 100, "maxWeight": 5},
    },
    "sets": {"data": [], "total": 45, "page": 1, "limit": 20, "totalPages": 3},
  };

  final detailsDto = ExerciseDetailsDto.fromJson(detailsJson);
  print('Exercise Details name: ${detailsDto.exercise?.name}');
  print('Exercise Details sets count: ${detailsDto.exercise?.count?.sets}');
  print(
    'Exercise Details comparison current maxWeight: ${detailsDto.comparison?.current?.maxWeight}',
  );
  assert(detailsDto.exercise?.count?.sets == 120);

  print('DTO Verification Passed!');
}
