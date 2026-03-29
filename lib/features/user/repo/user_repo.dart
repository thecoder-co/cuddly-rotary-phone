import 'package:calorie_tracker/core/services/api_handler/api_client_config.dart';
import 'package:calorie_tracker/core/services/api_handler/api_handler_models.dart';
import 'package:calorie_tracker/core/services/api_handler/app_endpoints.dart';
import 'package:calorie_tracker/packages/packages.dart';
import '../models/profile_dto.dart';

class UserRepo {
  final BackendService _apiService = BackendService(Dio());

  Future<ResponseModel<ProfileDto>> getMe() async {
    final response = await _apiService.runCall(
      _apiService.dio.get('${AppEndpoints.baseUrl}/user/me'),
    );

    final int statusCode = response.statusCode ?? 0;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: ProfileDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }
}
