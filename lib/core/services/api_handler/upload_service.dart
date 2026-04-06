import 'package:calorie_tracker/core/services/api_handler/api_client_config.dart';
import 'package:calorie_tracker/core/services/api_handler/app_endpoints.dart';
import 'package:calorie_tracker/core/services/api_handler/api_handler_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uploadServiceProvider = Provider((ref) => UploadService());

class UploadService {
  final BackendService _apiService = BackendService(Dio());

  Future<ResponseModel<String>> uploadFile(String filePath) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });

    Response response = await _apiService.runCall(
      _apiService.dio.post('${AppEndpoints.baseUrl}/upload', data: formData),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: 'Upload successful',
        data: response.data['url'],
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message:
          response.data?['message'] ?? 'Something went wrong during upload',
    );
  }
}
