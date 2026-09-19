import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/packages/packages.dart';

import '../models/auth_dto.dart';

class AuthRepo {
  final BackendService _apiService = BackendService(Dio());
  final BackendService _anonymousApiService = BackendService(
    Dio(),
    // Creating a guest account is not safely replayable until the backend has
    // an idempotency contract. The UI exposes an explicit retry instead.
    enableRetries: false,
  );

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

  Future<ResponseModel> linkAnonymousEmail({
    required CreateUserDto model,
  }) async {
    Response response = await _apiService.runCall(
      _apiService.dio.post(
        '${AppEndpoints.baseUrl}/account/link-email',
        data: {'email': model.email, 'name': model.name},
      ),
    );

    final int statusCode = response.statusCode ?? 0;
    if (statusCode >= 200 && statusCode < 300) {
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
      message: response.data?['message'] ?? 'Unable to link this email',
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
      final session = _parseSession(response.data);
      if (session == null) {
        return ResponseModel(
          statusCode: statusCode,
          message: 'The server returned an invalid session.',
        );
      }
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: session,
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<AuthResponseDto>> registerAnonymous({
    required AnonymousRegisterDto model,
  }) async {
    Response response = await _anonymousApiService.runCall(
      _anonymousApiService.dio.post(
        '${AppEndpoints.baseUrl}/anonymous-register',
        data: model.toJson(),
        options: Options(extra: {CustomExtras.tokenRequired: false}),
      ),
    );

    final int statusCode = response.statusCode ?? 0;
    if (statusCode >= 200 && statusCode < 300) {
      final session = _parseSession(response.data);
      if (session == null) {
        return ResponseModel(
          statusCode: statusCode,
          message: 'The server returned an invalid guest session.',
        );
      }
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: session,
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Unable to create a guest account',
    );
  }

  Future<ResponseModel<AuthResponseDto>> refreshToken() async {
    final refreshToken = LocalData.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      return ResponseModel(
        statusCode: 401,
        message: 'No saved session is available',
      );
    }
    Response response = await _apiService.runCall(
      _apiService.dio.get(
        '${AppEndpoints.baseUrl}/token/refresh',
        options: Options(
          headers: {'Authorization': 'Bearer $refreshToken'},
          extra: {CustomExtras.tokenRequired: false},
        ),
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      final session = _parseSession(response.data);
      if (session == null) {
        return ResponseModel(
          statusCode: statusCode,
          message: 'The server returned an invalid refreshed session.',
        );
      }
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: session,
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  AuthResponseDto? _parseSession(dynamic data) {
    if (data is! Map) return null;
    try {
      return AuthResponseDto.fromJson(Map<String, dynamic>.from(data));
    } catch (_) {
      return null;
    }
  }
}
