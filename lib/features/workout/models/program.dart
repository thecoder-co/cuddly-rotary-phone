import 'package:calorie_tracker/features/meals/models/meal.dart'; // For SyncStatus
import 'package:isar_community/isar.dart';

part 'program.g.dart';

@collection
class Program {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? backendId;

  String? name;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  @enumerated
  SyncStatus syncStatus = SyncStatus.pendingCreate;

  List<ProgramExercise> exercises = [];

  Program({
    this.backendId,
    this.name,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.syncStatus = SyncStatus.pendingCreate,
    this.exercises = const [],
  });

  Program copyWith({
    String? backendId,
    String? name,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
    List<ProgramExercise>? exercises,
  }) {
    return Program(
      backendId: backendId ?? this.backendId,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      exercises: exercises ?? this.exercises,
    )..id = id;
  }
}

@embedded
class ProgramExercise {
  String? backendId;
  String? exerciseId;
  int? order;

  ProgramExercise({
    this.backendId,
    this.exerciseId,
    this.order,
  });

  ProgramExercise copyWith({
    String? backendId,
    String? exerciseId,
    int? order,
  }) {
    return ProgramExercise(
      backendId: backendId ?? this.backendId,
      exerciseId: exerciseId ?? this.exerciseId,
      order: order ?? this.order,
    );
  }
}
