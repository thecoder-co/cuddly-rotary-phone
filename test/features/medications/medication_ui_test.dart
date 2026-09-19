import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/features/medications/models/medication_models.dart';
import 'package:calorie_tracker/features/medications/presentation/add_medication_flow.dart';
import 'package:calorie_tracker/features/medications/presentation/today_medications_screen.dart';
import 'package:calorie_tracker/features/medications/presentation/medication_history_screen.dart';
import 'package:calorie_tracker/features/medications/presentation/medication_detail_screen.dart';
import 'package:calorie_tracker/features/medications/presentation/medications_list_screen.dart';
import 'package:calorie_tracker/features/medications/presentation/record_dose_sheet.dart';
import 'package:calorie_tracker/features/medications/providers/medication_provider.dart';
import 'package:calorie_tracker/features/medications/repo/local_medication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tzdata;

class EmptyMedicationRepo implements LocalMedicationRepo {
  @override
  Stream<void> watchDoseChanges() => Stream<void>.value(null);
  @override
  Future<List<MedicationDoseRecordLocal>> recordsBetween(
    DateTime from,
    DateTime to,
  ) async => [];
  @override
  Future<List<MedicationLocal>> getActiveMedications() async => [];
  @override
  Future<List<MedicationScheduleLocal>> schedulesFor(String id) async => [];
  @override
  Future<MedicationSupplyLocal?> supplyFor(String id) async => null;
  @override
  Future<List<MedicationDoseRecordLocal>> allRecords() async => [];
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  setUp(() async {
    tzdata.initializeTimeZones();
    SharedPreferences.setMockInitialValues({});
    LocalData.prefs = await SharedPreferences.getInstance();
  });

  testWidgets('add flow renders material fields and validates required name', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: AddMedicationFlow())),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.byType(TextFormField), findsWidgets);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Required'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).first, 'Test medication');
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Dose & instructions'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('empty Today renders without missing Material or layout errors', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localMedicationRepoProvider.overrideWithValue(EmptyMedicationRepo()),
        ],
        child: const MaterialApp(home: TodayMedicationsScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('No doses scheduled'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'injectable selection clears tablet dose and summary updates live',
    (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: AddMedicationFlow())),
      );
      await tester.pumpAndSettle();
      expect(find.byType(DropdownButtonFormField<String>), findsNWidgets(3));
      await tester.enterText(
        find.byType(TextFormField).first,
        'Injection fixture',
      );
      await tester.tap(find.byKey(const ValueKey('category-Form-tablet')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Injectable').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Take 1 tablet'), findsNothing);
      expect(find.text('Dose: enter quantity and unit'), findsOneWidget);
      final fields = tester
          .widgetList<TextFormField>(find.byType(TextFormField))
          .toList();
      expect(fields[0].controller!.text, isEmpty);
      expect(fields[1].controller!.text, isEmpty);
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.text('Dose & instructions'), findsOneWidget);
      await tester.enterText(find.byType(TextFormField).at(0), '0.5');
      await tester.enterText(find.byType(TextFormField).at(1), 'mL');
      await tester.pumpAndSettle();
      expect(find.text('Dose: 0.5 mL'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  for (final brightness in Brightness.values) {
    for (final scale in [1.0, 1.6]) {
      testWidgets(
        'main medication screens render at $brightness and text scale $scale',
        (tester) async {
          await tester.binding.setSurfaceSize(const Size(430, 932));
          addTearDown(() => tester.binding.setSurfaceSize(null));
          final medication = MedicationLocal()
            ..clientId = 'test'
            ..displayName = 'QA Vitamin'
            ..strengthValue = 500
            ..strengthUnit = 'mg';
          final record = MedicationDoseRecordLocal()
            ..occurrenceKey = 'prn:test'
            ..medicationClientId = 'test'
            ..timezone = 'UTC'
            ..outcome = MedicationDoseOutcome.taken;
          final pages = <Widget>[
            const TodayMedicationsScreen(),
            const MedicationsListScreen(),
            const MedicationHistoryScreen(),
            const MedicationDetailScreen(clientId: 'test'),
            RecordDoseSheet(
              occurrence: MedicationOccurrence(
                occurrenceKey: 'prn:test',
                medication: medication,
                schedule: null,
                slot: MedicationDoseSlotLocal()
                  ..clientId = 'slot'
                  ..localTime = '00:00',
                scheduledAt: null,
                scheduledLocal: '',
                outcome: MedicationDoseOutcome.due,
              ),
            ),
          ];
          for (final page in pages) {
            final originalErrorHandler = FlutterError.onError;
            FlutterError.onError = (details) {
              FlutterError.dumpErrorToConsole(details, forceReport: true);
              originalErrorHandler?.call(details);
            };
            await tester.pumpWidget(
              ProviderScope(
                overrides: [
                  localMedicationRepoProvider.overrideWithValue(
                    EmptyMedicationRepo(),
                  ),
                  medicationsProvider.overrideWith(
                    (ref) => Stream.value([medication]),
                  ),
                  medicationHistoryProvider.overrideWith(
                    (ref) => Stream.value([record]),
                  ),
                  medicationByIdProvider.overrideWith(
                    (ref, id) async => medication,
                  ),
                ],
                child: MaterialApp(
                  theme: ThemeData(brightness: brightness),
                  builder: (context, child) => MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(textScaler: TextScaler.linear(scale)),
                    child: child!,
                  ),
                  home: page,
                ),
              ),
            );
            await tester.pumpAndSettle();
            FlutterError.onError = originalErrorHandler;
            expect(
              tester.takeException(),
              isNull,
              reason: '${page.runtimeType}: $brightness, scale $scale',
            );
            await tester.pumpWidget(const SizedBox());
          }
        },
      );
    }
  }
}
