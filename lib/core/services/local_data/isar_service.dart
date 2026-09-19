import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import '../../../features/meals/models/meal.dart';
import '../../../features/workout/models/program.dart';
import '../../../features/workout/models/exercise.dart';
import '../../../features/workout/models/workout_set.dart';
import '../../../features/medications/models/medication_models.dart';

class IsarService {
  static late Isar isar;
  static late Isar medicationIsar;
  static late Isar _legacyIsar;
  static String? _activeAccountId;
  static bool _trackingAccountOpen = false;

  static List<CollectionSchema<dynamic>> get _trackingSchemas => [
    MealSchema,
    ProgramSchema,
    ExerciseSchema,
    WorkoutSetSchema,
  ];

  static List<CollectionSchema<dynamic>> get _legacySchemas => [
    ..._trackingSchemas,
    MedicationLocalSchema,
    MedicationScheduleLocalSchema,
    MedicationDoseRecordLocalSchema,
    MedicationDoseActionLocalSchema,
    MedicationSupplyLocalSchema,
    MedicationPendingOperationSchema,
  ];

  static String _accountDatabaseName(String? userId) =>
      'qarrtrack_account_${sha256.convert(utf8.encode(userId ?? 'signed-out'))}';

  static Future<void> openAccount(
    String? userId, {
    bool migrateLegacy = false,
  }) async {
    if (_trackingAccountOpen && _activeAccountId == userId) return;
    final dir = await getApplicationDocumentsDirectory();
    final name = _accountDatabaseName(userId);
    isar =
        Isar.getInstance(name) ??
        await Isar.open(_trackingSchemas, name: name, directory: dir.path);
    _activeAccountId = userId;
    _trackingAccountOpen = true;

    if (migrateLegacy && userId != null) {
      await _migrateVerifiedLegacyRecords(userId);
    }
  }

  /// Moves only records whose ownership is demonstrable. Meals and historical
  /// workout sets in the old shared store did not carry an owner, so they stay
  /// untouched for deliberate reconciliation instead of being guessed into the
  /// first account to sign in.
  static Future<void> _migrateVerifiedLegacyRecords(String userId) async {
    final programs = await _legacyIsar.programs
        .filter()
        .userIdEqualTo(userId)
        .findAll();
    final exercises = await _legacyIsar.exercises
        .filter()
        .ownerIdEqualTo(userId)
        .findAll();
    if (programs.isEmpty && exercises.isEmpty) return;

    await isar.writeTxn(() async {
      await isar.programs.putAll(programs);
      await isar.exercises.putAll(exercises);
    });
    final programsVerified = await isar.programs.getAll(
      programs.map((item) => item.id).toList(),
    );
    final exercisesVerified = await isar.exercises.getAll(
      exercises.map((item) => item.id).toList(),
    );
    if (programsVerified.any((item) => item == null) ||
        exercisesVerified.any((item) => item == null)) {
      throw StateError(
        'Account migration verification failed; legacy records were retained.',
      );
    }
  }

  static Future<bool> hasAmbiguousLegacyTrackingData() async =>
      await _legacyIsar.meals.count() > 0 ||
      await _legacyIsar.workoutSets.count() > 0;

  static Future<void> openMedicationAccount(
    String? userId, {
    bool migrateLegacy = false,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final name =
        'medication_${sha256.convert(utf8.encode(userId ?? 'signed-out'))}';
    medicationIsar =
        Isar.getInstance(name) ??
        await Isar.open(
          [
            MedicationLocalSchema,
            MedicationScheduleLocalSchema,
            MedicationDoseRecordLocalSchema,
            MedicationDoseActionLocalSchema,
            MedicationSupplyLocalSchema,
            MedicationPendingOperationSchema,
          ],
          name: name,
          directory: dir.path,
        );
    // Only the account already signed in at upgrade may adopt legacy data.
    // A later sign-in must never inherit another account's shared snapshot.
    if (migrateLegacy &&
        userId != null &&
        await _legacyIsar.medicationLocals.count() > 0) {
      final medications = await _legacyIsar.medicationLocals.where().findAll();
      final schedules = await _legacyIsar.medicationScheduleLocals
          .where()
          .findAll();
      final records = await _legacyIsar.medicationDoseRecordLocals
          .where()
          .findAll();
      final actions = await _legacyIsar.medicationDoseActionLocals
          .where()
          .findAll();
      final supplies = await _legacyIsar.medicationSupplyLocals
          .where()
          .findAll();
      final pending = await _legacyIsar.medicationPendingOperations
          .where()
          .findAll();
      await medicationIsar.writeTxn(() async {
        await medicationIsar.medicationLocals.putAll(medications);
        await medicationIsar.medicationScheduleLocals.putAll(schedules);
        await medicationIsar.medicationDoseRecordLocals.putAll(records);
        await medicationIsar.medicationDoseActionLocals.putAll(actions);
        await medicationIsar.medicationSupplyLocals.putAll(supplies);
        await medicationIsar.medicationPendingOperations.putAll(pending);
      });
      final verified = [
        (await medicationIsar.medicationLocals.getAll(
          medications.map((v) => v.id).toList(),
        )).every((v) => v != null),
        (await medicationIsar.medicationScheduleLocals.getAll(
          schedules.map((v) => v.id).toList(),
        )).every((v) => v != null),
        (await medicationIsar.medicationDoseRecordLocals.getAll(
          records.map((v) => v.id).toList(),
        )).every((v) => v != null),
        (await medicationIsar.medicationDoseActionLocals.getAll(
          actions.map((v) => v.id).toList(),
        )).every((v) => v != null),
        (await medicationIsar.medicationSupplyLocals.getAll(
          supplies.map((v) => v.id).toList(),
        )).every((v) => v != null),
        (await medicationIsar.medicationPendingOperations.getAll(
          pending.map((v) => v.id).toList(),
        )).every((v) => v != null),
      ].every((v) => v);
      if (!verified)
        throw StateError(
          'Medication migration verification failed; original records retained.',
        );
      // The legacy collection is deliberately retained. Its source did not
      // establish ownership and deleting it here would make a failed migration
      // irreversible. A later explicit reconciliation can remove it safely.
    }
  }

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _legacyIsar =
        Isar.getInstance() ??
        await Isar.open(_legacySchemas, directory: dir.path);
    // Before a session resolves, no account-owned repository may read the old
    // shared store. A signed-out partition keeps bootstrap isolated as well.
    await openAccount(null);
  }

  static Future<void> clearAll() async {
    await isar.writeTxn(() => isar.clear());
    await medicationIsar.writeTxn(() => medicationIsar.clear());
  }
}
