import 'dart:convert';
import 'dart:async';
import '../../../core/services/local_data/local_data.dart';
import '../repo/local_medication_repo.dart';
import '../repo/medication_repo.dart';
import '../models/medication_models.dart';

class MedicationSyncService {
  final LocalMedicationRepo local;
  final MedicationCloudRepo cloud;
  final String? accountId;
  Future<void>? _inFlight;
  bool _runAgain = false;
  bool _pullRequested = false;
  bool _retryRequested = false;
  MedicationSyncService({required this.local, required this.cloud})
    : accountId = LocalData.userId;

  bool get _isActiveAccount =>
      accountId != null &&
      accountId == LocalData.userId &&
      LocalData.token != null;

  Future<MedicationLocal?> _resolveMedication(String clientId) async {
    var medication = await local.getMedication(clientId);
    if (medication != null && medication.backendId == null) {
      // Stable client/server IDs allow recovery of an old malformed-ack bug
      // without dropping queued changes or replacing them with a remote pull.
      final remote = await cloud.fetchMedication(clientId);
      await local.applyCreatedMedication(clientId, remote);
      medication = await local.getMedication(clientId);
    }
    return medication;
  }

  Future<void> syncPending({bool pullRemote = true, bool retryNow = false}) {
    if (!_isActiveAccount) return Future.value();
    _pullRequested |= pullRemote;
    _retryRequested |= retryNow;
    if (_inFlight != null) {
      _runAgain = true;
      return _inFlight!;
    }
    final complete = Completer<void>();
    _inFlight = complete.future;
    () async {
      try {
        do {
          _runAgain = false;
          final pull = _pullRequested;
          final retry = _retryRequested;
          _pullRequested = false;
          _retryRequested = false;
          await _syncOnce(pullRemote: pull, retryNow: retry);
        } while (_runAgain && _isActiveAccount);
      } catch (_) {
        // The durable queue remains intact if storage/account state changes.
      } finally {
        _inFlight = null;
        complete.complete();
      }
    }();
    return complete.future;
  }

  Future<void> _syncOnce({
    required bool pullRemote,
    required bool retryNow,
  }) async {
    if (!_isActiveAccount) return;
    var uploaded = false;
    for (final pending in await local.pendingOperations()) {
      if (!_isActiveAccount) return;
      if (!retryNow &&
          (pending.nextRetryAt?.isAfter(DateTime.now()) ?? false)) {
        break;
      }
      try {
        final body = Map<String, dynamic>.from(
          jsonDecode(pending.bodyJson) as Map,
        );
        if (pending.operationType == 'CREATE_MEDICATION') {
          final result = await cloud.create(body);
          await local.applyCreatedMedication(pending.clientOperationId, result);
        } else if (pending.operationType == 'UPDATE_MEDICATION') {
          final clientId = body['clientId'] as String;
          final medication = await _resolveMedication(clientId);
          if (medication?.backendId == null) break;
          final result = await cloud.update(medication!.backendId!, body);
          await local.applyCreatedMedication(clientId, result);
        } else if (pending.operationType == 'DOSE_ACTION') {
          final medication = await _resolveMedication(
            body.remove('medicationClientId') as String,
          );
          if (medication?.backendId == null) break;
          body['medicationId'] = medication!.backendId;
          final scheduleClientId = body.remove('scheduleClientId') as String?;
          if (scheduleClientId != null) {
            body['scheduleRevisionId'] = (await local.getSchedule(
              scheduleClientId,
            ))?.backendId;
          }
          final result = await cloud.syncDose(body);
          final item = (result['results'] as List).first as Map;
          if (item['accepted'] != true) {
            throw StateError(
              item['error']?.toString() ?? 'Dose action rejected',
            );
          }
        } else if (pending.operationType == 'STATUS') {
          final medication = await _resolveMedication(
            body['medicationClientId'] as String,
          );
          if (medication?.backendId == null) break;
          final result = await cloud.setStatus(
            medication!.backendId!,
            body['status'] as String,
          );
          await local.applyCreatedMedication(medication.clientId, result);
        } else if (pending.operationType == 'SUPPLY_ADJUSTMENT') {
          final medication = await _resolveMedication(
            body.remove('medicationClientId') as String,
          );
          if (medication?.backendId == null) break;
          await cloud.adjustSupply(medication!.backendId!, body);
        } else if (pending.operationType == 'DELETE_ALL') {
          await cloud.clearMedicationData();
        } else {
          throw StateError('Unsupported pending medication operation');
        }
        await local.completeOperation(pending.id);
        uploaded = true;
      } catch (error) {
        await local.failOperation(pending, error);
        break;
      }
    }
    if ((pullRemote || uploaded) && (await local.pendingOperations()).isEmpty) {
      try {
        await local.mergeRemoteData(
          await cloud.fetchMedications(),
          await cloud.fetchDoseRecords(),
        );
      } catch (_) {
        // Offline reads keep the durable local snapshot and retry later.
      }
    }
  }
}
