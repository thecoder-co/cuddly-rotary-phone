import 'dart:async';
import 'dart:convert';
import 'package:calorie_tracker/core/services/api_handler/api_client_config.dart';
import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/features/medications/models/medication_models.dart';
import 'package:calorie_tracker/features/medications/repo/local_medication_repo.dart';
import 'package:calorie_tracker/features/medications/repo/medication_repo.dart';
import 'package:calorie_tracker/features/medications/services/medication_sync_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QueueRepo implements LocalMedicationRepo {
  final queue = <MedicationPendingOperation>[];
  final medication = MedicationLocal()
    ..clientId = 'med'
    ..backendId = 'med'
    ..displayName = 'Sync test';
  int failures = 0, completed = 0, merges = 0;
  void enqueue({DateTime? retry}) => queue.add(
    MedicationPendingOperation()
      ..id = queue.length + 1
      ..clientOperationId = 'op-${queue.length}'
      ..operationType = 'STATUS'
      ..bodyJson = jsonEncode({
        'medicationClientId': 'med',
        'status': 'archived',
      })
      ..nextRetryAt = retry,
  );
  @override
  Future<List<MedicationPendingOperation>> pendingOperations() async => [
    ...queue,
  ];
  @override
  Future<MedicationLocal?> getMedication(String id) async => medication;
  @override
  Future<void> completeOperation(int id) async {
    completed++;
    queue.removeWhere((op) => op.id == id);
  }

  @override
  Future<void> failOperation(
    MedicationPendingOperation op,
    Object error,
  ) async {
    failures++;
    op.lastError = error.toString();
  }

  @override
  Future<void> applyCreatedMedication(
    String id,
    Map<String, dynamic> response,
  ) async {
    medication.backendId = response['id'];
  }

  @override
  Future<void> mergeRemoteData(
    List<Map<String, dynamic>> meds,
    List<Map<String, dynamic>> records,
  ) async {
    if (queue.isEmpty) merges++;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class CloudRepo implements MedicationCloudRepo {
  int medicationReads = 0, historyReads = 0, writes = 0;
  bool failWrite = false;
  Completer<void>? holdFirstRead;
  @override
  Future<Map<String, dynamic>> fetchMedication(String id) async => {'id':id,'version':1};
  @override
  Future<List<Map<String, dynamic>>> fetchMedications() async {
    medicationReads++;
    if (medicationReads == 1) await holdFirstRead?.future;
    return [];
  }

  @override
  Future<List<Map<String, dynamic>>> fetchDoseRecords() async {
    historyReads++;
    return [];
  }

  @override
  Future<Map<String, dynamic>> setStatus(String id, String status) async {
    writes++;
    if (failWrite) throw StateError('Request failed');
    return {'id': id, 'version': 2};
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ErrorBackend implements BackendService {
  @override
  final dio = Dio();
  ErrorBackend(int status) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) => handler.resolve(
          Response(
            requestOptions: options,
            statusCode: status,
            data: {'message': 'request failed'},
          ),
        ),
      ),
    );
  }
  @override
  Future<Response> runCall(Future<Response> call) => call;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'token': 'test-token',
      'userId': 'test-user',
    });
    LocalData.prefs = await SharedPreferences.getInstance();
  });
  test('idle queue checks make zero HTTP reads or writes', () async {
    final cloud = CloudRepo();
    final sync = MedicationSyncService(local: QueueRepo(), cloud: cloud);
    for (var i = 0; i < 4; i++) {
      await sync.syncPending(pullRemote: false);
    }
    expect(
      [cloud.medicationReads, cloud.historyReads, cloud.writes],
      [0, 0, 0],
    );
  });
  test('entry/resume refreshes both remote collections', () async {
    final cloud = CloudRepo();
    await MedicationSyncService(local: QueueRepo(), cloud: cloud).syncPending();
    expect([cloud.medicationReads, cloud.historyReads], [1, 1]);
  });
  test('failed upload remains queued and retry acknowledges it once', () async {
    final local = QueueRepo()..enqueue();
    final cloud = CloudRepo()..failWrite = true;
    final sync = MedicationSyncService(local: local, cloud: cloud);
    await sync.syncPending();
    expect(local.queue, hasLength(1));
    expect(local.completed, 0);
    expect(local.medication.backendId, 'med');
    expect(cloud.medicationReads, 0);
    cloud.failWrite = false;
    await sync.syncPending(pullRemote: false);
    expect(local.queue, isEmpty);
    expect(local.completed, 1);
    expect(cloud.medicationReads, 1);
    await sync.syncPending(pullRemote: false);
    expect(cloud.writes, 2);
    expect(cloud.medicationReads, 1);
  });
  test('local change during an in-flight pull is not lost', () async {
    final local = QueueRepo();
    final cloud = CloudRepo()..holdFirstRead = Completer<void>();
    final sync = MedicationSyncService(local: local, cloud: cloud);
    final first = sync.syncPending();
    await Future<void>.delayed(Duration.zero);
    local.enqueue();
    final second = sync.syncPending(pullRemote: false);
    cloud.holdFirstRead!.complete();
    await Future.wait([first, second]);
    expect(local.queue, isEmpty);
    expect(cloud.writes, 1);
  });
  test('timer respects backoff; resume can retry immediately', () async {
    final local = QueueRepo()
      ..enqueue(retry: DateTime.now().add(const Duration(hours: 1)));
    final cloud = CloudRepo();
    final sync = MedicationSyncService(local: local, cloud: cloud);
    await sync.syncPending(pullRemote: false);
    expect(cloud.writes, 0);
    await sync.syncPending(retryNow: true);
    expect(cloud.writes, 1);
  });
  test('missing legacy backend identity is repaired before queued upload', () async {
    final local = QueueRepo()..enqueue();
    local.medication.backendId = null;
    final cloud = CloudRepo();
    await MedicationSyncService(local:local,cloud:cloud).syncPending();
    expect(local.medication.backendId,'med');
    expect(cloud.writes,1);
    expect(local.queue,isEmpty);
  });
  for (final status in [-1, 401, 409, 503]) {
    test(
      'HTTP/transport $status cannot be acknowledged as a successful mutation',
      () async {
        final cloud = MedicationCloudRepo(backend: ErrorBackend(status));
        await expectLater(cloud.setStatus('med', 'archived'), throwsStateError);
        await expectLater(cloud.adjustSupply('med', {}), throwsStateError);
        await expectLater(cloud.clearMedicationData(), throwsStateError);
        await expectLater(cloud.create({}), throwsStateError);
      },
    );
  }
}
