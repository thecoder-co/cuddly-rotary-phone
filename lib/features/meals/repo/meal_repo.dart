import 'package:calorie_tracker/core/services/api_handler/api_client_config.dart';
import 'package:calorie_tracker/core/services/api_handler/app_endpoints.dart';
import 'package:calorie_tracker/core/services/api_handler/api_handler_models.dart';
import 'package:calorie_tracker/packages/packages.dart';

import '../models/meal_dto.dart';
import '../models/meal_analytics_dto.dart';

class MealCloudRepo {
  final BackendService _apiService = BackendService(Dio());

  Future<ResponseModel<MealResponseDto>> createMeal(CreateMealDto model) async {
    Response response = await _apiService.runCall(
      _apiService.dio.post(
        '${AppEndpoints.baseUrl}'
        '/meals',
        data: model.toJson(),
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.data['message'],
        data: MealResponseDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<MealResponseDto>> updateMeal(
    String id,
    UpdateMealDto model,
  ) async {
    Response response = await _apiService.runCall(
      _apiService.dio.patch(
        '${AppEndpoints.baseUrl}/meals/$id',
        data: model.toJson(),
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: MealResponseDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel> deleteMeal(String id) async {
    Response response = await _apiService.runCall(
      _apiService.dio.delete(
        '${AppEndpoints.baseUrl}'
        '/meals/$id',
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: response.data,
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<DailyMealDto>> getDailyMeals(String date) async {
    Response response = await _apiService.runCall(
      _apiService.dio.get('${AppEndpoints.baseUrl}/meals/daily?date=$date'),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      // NOTE: Here we should ideally sync the returned data with LocalDB.
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: DailyMealDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<AllMealResponseDto>> getAllMeals({
    String? name,
    String? type,
    double? caloriesPerGramLt,
    double? caloriesPerGramGte,
    double? caloriesPerGramEq,
    double? proteinPerGramLt,
    double? proteinPerGramGte,
    double? proteinPerGramEq,
    double? fatPerGramLt,
    double? fatPerGramGte,
    double? fatPerGramEq,
    double? carbsPerGramLt,
    double? carbsPerGramGte,
    double? carbsPerGramEq,
    double? fibrePerGramLt,
    double? fibrePerGramGte,
    double? fibrePerGramEq,
  }) async {
    Response response = await _apiService.runCall(
      _apiService.dio.get(
        '${AppEndpoints.baseUrl}'
        '/meals',
        queryParameters: {
          'page': 1,
          'limit': 100,
          if (name != null) 'name': name,
          if (type != null) 'type': type,
          if (caloriesPerGramLt != null) 'caloriesPerGramLt': caloriesPerGramLt,
          if (caloriesPerGramGte != null)
            'caloriesPerGramGte': caloriesPerGramGte,
          if (caloriesPerGramEq != null) 'caloriesPerGramEq': caloriesPerGramEq,
          if (proteinPerGramLt != null) 'proteinPerGramLt': proteinPerGramLt,
          if (proteinPerGramGte != null) 'proteinPerGramGte': proteinPerGramGte,
          if (proteinPerGramEq != null) 'proteinPerGramEq': proteinPerGramEq,
          if (fatPerGramLt != null) 'fatPerGramLt': fatPerGramLt,
          if (fatPerGramGte != null) 'fatPerGramGte': fatPerGramGte,
          if (fatPerGramEq != null) 'fatPerGramEq': fatPerGramEq,
          if (carbsPerGramLt != null) 'carbsPerGramLt': carbsPerGramLt,
          if (carbsPerGramGte != null) 'carbsPerGramGte': carbsPerGramGte,
          if (carbsPerGramEq != null) 'carbsPerGramEq': carbsPerGramEq,
          if (fibrePerGramLt != null) 'fibrePerGramLt': fibrePerGramLt,
          if (fibrePerGramGte != null) 'fibrePerGramGte': fibrePerGramGte,
          if (fibrePerGramEq != null) 'fibrePerGramEq': fibrePerGramEq,
        },
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      // NOTE: Here we should ideally sync the returned data with LocalDB.
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: AllMealResponseDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<MealAnalyticsDto>> getAnalytics({
    String? date,
    String? dateGte,
    String? dateLt,
  }) async {
    final queryParams = <String, dynamic>{};
    if (date != null) queryParams['date'] = date;
    if (dateGte != null) queryParams['dateGte'] = dateGte;
    if (dateLt != null) queryParams['dateLt'] = dateLt;

    Response response = await _apiService.runCall(
      _apiService.dio.get(
        '${AppEndpoints.baseUrl}/meals/analytics',
        queryParameters: queryParams,
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: MealAnalyticsDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }
}
