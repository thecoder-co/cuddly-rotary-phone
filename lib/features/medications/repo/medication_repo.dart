import 'package:dio/dio.dart';
import '../../../core/services/api_handler/api_client_config.dart';
import '../../../core/services/local_data/local_data.dart';

class MedicationCloudRepo {
  final BackendService backend;
  MedicationCloudRepo({BackendService? backend})
    : backend = backend ?? BackendService(Dio(), enableRetries: false) {
    final owner = LocalData.userId;
    this.backend.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (owner == null ||
              owner != LocalData.userId ||
              LocalData.token == null) {
            handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.cancel,
                message: 'Account changed',
              ),
            );
            return;
          }
          handler.next(options);
        },
      ),
    );
  }

  Future<Response<dynamic>> _run(Future<Response<dynamic>> call) async {
    final response = await backend.runCall(call);
    final status = response.statusCode ?? -1;
    if (status < 200 || status >= 300) {
      // BackendService converts HTTP/transport failures into Response objects.
      // A durable sync operation must never acknowledge those as success.
      throw StateError(
        'Medication sync request failed ($status); change retained for retry.',
      );
    }
    return response;
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> body) async =>
      Map<String, dynamic>.from(
        (await _run(backend.dio.post('/medications', data: body))).data as Map,
      );

  Future<Map<String, dynamic>> fetchMedication(String id) async =>
      Map<String, dynamic>.from(
        (await _run(backend.dio.get('/medications/$id'))).data as Map,
      );
  Future<Map<String, dynamic>> syncDose(Map<String, dynamic> operation) async =>
      Map<String, dynamic>.from(
        (await _run(
              backend.dio.post(
                '/medication-dose-actions/sync',
                data: {
                  'operations': [operation],
                },
              ),
            )).data
            as Map,
      );

  Future<Map<String, dynamic>> update(
    String medicationId,
    Map<String, dynamic> body,
  ) async => Map<String, dynamic>.from(
    (await _run(
          backend.dio.patch('/medications/$medicationId', data: body),
        )).data
        as Map,
  );
  Future<Map<String, dynamic>> setStatus(
    String medicationId,
    String status,
  ) async {
    final action = switch (status) {
      'active' => 'resume',
      'paused' => 'pause',
      _ => 'archive',
    };
    final response = await _run(
      backend.dio.post('/medications/$medicationId/$action'),
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<void> adjustSupply(
    String medicationId,
    Map<String, dynamic> body,
  ) async {
    await _run(
      backend.dio.post(
        '/medications/$medicationId/supply-adjustments',
        data: body,
      ),
    );
  }

  Future<void> clearMedicationData() async {
    await _run(backend.dio.delete('/medications/data/all'));
  }

  Future<List<Map<String, dynamic>>> fetchMedications() async {
    return _fetchPages('/medications');
  }

  Future<List<Map<String, dynamic>>> fetchDoseRecords() =>
      _fetchPages('/medication-dose-records');

  Future<List<Map<String, dynamic>>> _fetchPages(String path) async {
    final result = <Map<String, dynamic>>[];
    var page = 1;
    while (true) {
      final data =
          (await _run(
                backend.dio.get(
                  path,
                  queryParameters: {'limit': 100, 'page': page},
                ),
              )).data
              as Map;
      result.addAll(
        (data['data'] as List? ?? const []).map(
          (item) => Map<String, dynamic>.from(item as Map),
        ),
      );
      if ((data['meta'] as Map?)?['next'] == null) break;
      page++;
    }
    return result;
  }
}
