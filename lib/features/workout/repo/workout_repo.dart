import 'package:calorie_tracker/core/services/api_handler/api_client_config.dart';
import 'package:calorie_tracker/core/services/api_handler/app_endpoints.dart';
import 'package:calorie_tracker/core/services/api_handler/api_handler_models.dart';
import 'package:calorie_tracker/packages/packages.dart';

import '../models/workout_dto.dart';
import '../models/workout_analytics_dto.dart';

class WorkoutCloudRepo {
  final BackendService _apiService = BackendService(Dio());

  // ----- Programs -----

  Future<ResponseModel<List<ProgramDto>>> getPrograms() async {
    Response response = await _apiService.runCall(
      _apiService.dio.get('${AppEndpoints.baseUrl}/programs'),
    );

    final statusCode = response.statusCode ?? 000;
    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: (response.data as List)
            .map((x) => ProgramDto.fromJson(x))
            .toList(),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<ProgramDto>> createProgram(
    CreateProgramDto model,
  ) async {
    Response response = await _apiService.runCall(
      _apiService.dio.post(
        '${AppEndpoints.baseUrl}/programs',
        data: model.toJson(),
      ),
    );

    final statusCode = response.statusCode ?? 000;
    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: ProgramDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<ProgramDto>> updateProgram(
    String id,
    UpdateProgramDto model,
  ) async {
    Response response = await _apiService.runCall(
      _apiService.dio.patch(
        '${AppEndpoints.baseUrl}/programs/$id',
        data: model.toJson(),
      ),
    );

    final statusCode = response.statusCode ?? 000;
    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: ProgramDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel> deleteProgram(String id) async {
    Response response = await _apiService.runCall(
      _apiService.dio.delete('${AppEndpoints.baseUrl}/programs/$id'),
    );

    final statusCode = response.statusCode ?? 000;
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

  // ----- Exercises -----

  Future<ResponseModel<List<ExerciseDto>>> getExercises() async {
    Response response = await _apiService.runCall(
      _apiService.dio.get('${AppEndpoints.baseUrl}/exercises'),
    );

    final statusCode = response.statusCode ?? 000;
    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: (response.data as List)
            .map((x) => ExerciseDto.fromJson(x))
            .toList(),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<List<ExerciseDto>>> getMyExercises() async {
    Response response = await _apiService.runCall(
      _apiService.dio.get('${AppEndpoints.baseUrl}/exercises/my'),
    );

    final statusCode = response.statusCode ?? 000;
    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: (response.data as List)
            .map((x) => ExerciseDto.fromJson(x))
            .toList(),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<PaginatedExercisesDto>> getPaginatedExercises({
    String? name,
    int page = 1,
    int limit = 20,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    if (name != null && name.isNotEmpty) {
      queryParams['name'] = name;
    }

    Response response = await _apiService.runCall(
      _apiService.dio.get(
        '${AppEndpoints.baseUrl}/exercises',
        queryParameters: queryParams,
      ),
    );

    final statusCode = response.statusCode ?? 000;
    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: PaginatedExercisesDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<ExerciseDetailsDto>> getExerciseDetails(
    String id, {
    int page = 1,
    int limit = 20,
  }) async {
    Response response = await _apiService.runCall(
      _apiService.dio.get(
        '${AppEndpoints.baseUrl}/exercises/$id',
        queryParameters: {'page': page, 'limit': limit},
      ),
    );

    final statusCode = response.statusCode ?? 000;
    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: ExerciseDetailsDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<ExerciseDto>> createExercise(
    CreateExerciseDto model,
  ) async {
    Response response = await _apiService.runCall(
      _apiService.dio.post(
        '${AppEndpoints.baseUrl}/exercises',
        data: model.toJson(),
      ),
    );

    final statusCode = response.statusCode ?? 000;
    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: ExerciseDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<ExerciseDto>> updateExercise(
    String id,
    CreateExerciseDto model,
  ) async {
    Response response = await _apiService.runCall(
      _apiService.dio.patch(
        '${AppEndpoints.baseUrl}/exercises/$id',
        data: model.toJson(),
      ),
    );

    final statusCode = response.statusCode ?? 000;
    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: ExerciseDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }
  Future<ResponseModel<List<ExerciseDto>>> addExercisesFromParent(
    AddExercisesDto model,
  ) async {
    Response response = await _apiService.runCall(
      _apiService.dio.post(
        '${AppEndpoints.baseUrl}/exercises/add-from-parent',
        data: model.toJson(),
      ),
    );

    final statusCode = response.statusCode ?? 000;
    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: (response.data as List)
            .map((x) => ExerciseDto.fromJson(x))
            .toList(),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  // ----- Sets -----

  Future<ResponseModel<WorkoutSetDto>> createSet(
    CreateWorkoutSetDto model,
  ) async {
    Response response = await _apiService.runCall(
      _apiService.dio.post(
        '${AppEndpoints.baseUrl}/sets',
        data: model.toJson(),
      ),
    );

    final statusCode = response.statusCode ?? 000;
    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: WorkoutSetDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel<WorkoutSetDto>> updateSet(
    String id,
    UpdateWorkoutSetDto model,
  ) async {
    Response response = await _apiService.runCall(
      _apiService.dio.patch(
        '${AppEndpoints.baseUrl}/sets/$id',
        data: model.toJson(),
      ),
    );

    final statusCode = response.statusCode ?? 000;
    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: WorkoutSetDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }

  Future<ResponseModel> deleteSet(String id) async {
    Response response = await _apiService.runCall(
      _apiService.dio.delete('${AppEndpoints.baseUrl}/sets/$id'),
    );

    final statusCode = response.statusCode ?? 000;
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

  // ----- Analytics -----

  Future<ResponseModel<WorkoutAnalyticsDataDto>> getAnalytics({
    String? dateGte,
    String? dateLt,
    String? exerciseId,
  }) async {
    final queryParams = <String, dynamic>{};
    if (dateGte != null) queryParams['dateGte'] = dateGte;
    if (dateLt != null) queryParams['dateLt'] = dateLt;
    if (exerciseId != null) queryParams['exerciseId'] = exerciseId;

    Response response = await _apiService.runCall(
      _apiService.dio.get(
        '${AppEndpoints.baseUrl}/workout/analytics',
        queryParameters: queryParams,
      ),
    );

    final statusCode = response.statusCode ?? 000;
    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: WorkoutAnalyticsDataDto.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data ?? {}),
      statusCode: statusCode,
      message: response.data?['message'] ?? 'Something went wrong',
    );
  }
}
