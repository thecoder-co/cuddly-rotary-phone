import 'package:calorie_tracker/features/meals/models/meal.dart'; // For SyncStatus
import 'package:isar_community/isar.dart';

part 'exercise.g.dart';

@collection
class Exercise {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? backendId;

  String? name;
  double? popularity;
  String? ownerId;
  String? oneRmFormula;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? localSetsCount;

  @enumerated
  SyncStatus syncStatus = SyncStatus.pendingCreate;

  Exercise({
    this.backendId,
    this.name,
    this.popularity,
    this.ownerId,
    this.oneRmFormula,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.localSetsCount = 0,
    this.syncStatus = SyncStatus.pendingCreate,
  });

  Exercise copyWith({
    String? backendId,
    String? name,
    double? popularity,
    String? ownerId,
    String? oneRmFormula,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? localSetsCount,
    SyncStatus? syncStatus,
  }) {
    return Exercise(
      backendId: backendId ?? this.backendId,
      name: name ?? this.name,
      popularity: popularity ?? this.popularity,
      ownerId: ownerId ?? this.ownerId,
      oneRmFormula: oneRmFormula ?? this.oneRmFormula,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      localSetsCount: localSetsCount ?? this.localSetsCount,
      syncStatus: syncStatus ?? this.syncStatus,
    )..id = id;
  }
}
