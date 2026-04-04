import 'package:calorie_tracker/features/meals/models/meal.dart'; // For SyncStatus
import 'package:isar_community/isar.dart';

part 'workout_set.g.dart';

@collection
class WorkoutSet {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? backendId;

  @Index()
  String? exerciseId; // mapping to Exercise.backendId

  int? reps;
  double? weight;
  String? comment;
  DateTime? date;

  @enumerated
  SyncStatus syncStatus = SyncStatus.pendingCreate;

  WorkoutSet({
    this.backendId,
    this.exerciseId,
    this.reps,
    this.weight,
    this.comment,
    this.date,
    this.syncStatus = SyncStatus.pendingCreate,
  });

  WorkoutSet copyWith({
    String? backendId,
    String? exerciseId,
    int? reps,
    double? weight,
    String? comment,
    DateTime? date,
    SyncStatus? syncStatus,
  }) {
    return WorkoutSet(
      backendId: backendId ?? this.backendId,
      exerciseId: exerciseId ?? this.exerciseId,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      syncStatus: syncStatus ?? this.syncStatus,
    )..id = id;
  }
}
