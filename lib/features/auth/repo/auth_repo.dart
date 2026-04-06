import 'package:calorie_tracker/core/services/api_handler/api_client_config.dart';
import 'package:calorie_tracker/core/services/api_handler/app_endpoints.dart';
import 'package:calorie_tracker/core/services/api_handler/api_handler_models.dart';
import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/packages/packages.dart';

import '../models/auth_dto.dart';

class AuthRepo {
  final BackendService _apiService = BackendService(Dio());

  Future<ResponseModel> createUser({required CreateUserDto model}) async {
    Response response = await _apiService.runCall(
      _apiService.dio.post(
        '${AppEndpoints.baseUrl}/create-user',
        data: model.toJson(),
        options: Options(extra: {CustomExtras.tokenRequired: false}),
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.data?['message'] ?? response.statusMessage,
        data: response.data,
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel> sendLoginOtp({required SendLoginOtpDto model}) async {
    Response response = await _apiService.runCall(
      _apiService.dio.post(
        '${AppEndpoints.baseUrl}/send-login-otp',
        data: model.toJson(),
        options: Options(extra: {CustomExtras.tokenRequired: false}),
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.data?['message'] ?? response.statusMessage,
        data: response.data,
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<AuthResponseDto>> verifyToken({
    required TokenDto model,
  }) async {
    Response response = await _apiService.runCall(
      _apiService.dio.post(
        '${AppEndpoints.baseUrl}/token',
        data: model.toJson(),
        options: Options(extra: {CustomExtras.tokenRequired: false}),
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: AuthResponseDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<AuthResponseDto>> refreshToken() async {
    Response response = await _apiService.runCall(
      _apiService.dio.get(
        '${AppEndpoints.baseUrl}/token/refresh',
        options: Options(
          headers: {'Authorization': 'Bearer ${LocalData.refreshToken}'},
          extra: {CustomExtras.tokenRequired: false},
        ),
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: AuthResponseDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }
}
