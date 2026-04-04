import 'dart:io';

import 'api_response.dart';
import 'package:dio/dio.dart';

/// Status code used when the failure is not a valid backend response.
/// This includes: network timeouts, no connectivity, 5xx server errors.
const int kNetworkErrorCode = -1;

Response handleError(DioException e) {
  switch (e.type) {
    case DioExceptionType.cancel:
      return Response(
        statusCode: kNetworkErrorCode,
        data: apiResponse(message: 'Request cancelled!'),
        requestOptions: RequestOptions(path: ''),
      );

    case DioExceptionType.connectionTimeout:
    case DioExceptionType.connectionError:
      return Response(
        statusCode: kNetworkErrorCode,
        data: apiResponse(message: 'Network connection timed out!'),
        requestOptions: RequestOptions(path: ''),
      );

    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.badCertificate:
      return Response(
        statusCode: kNetworkErrorCode,
        data: apiResponse(
          message: 'Something went wrong. Please try again later!',
        ),
        requestOptions: RequestOptions(path: ''),
      );

    case DioExceptionType.unknown:
      return Response(
        statusCode: kNetworkErrorCode,
        data: apiResponse(
          message: e.error is SocketException
              ? 'Please check your network connection!'
              : 'Network connection issue',
        ),
        requestOptions: RequestOptions(path: ''),
      );

    case DioExceptionType.badResponse:
      final sc = e.response?.statusCode ?? 0;
      // Treat 5xx as a network/server error – not a handled API failure
      final effectiveCode = (sc >= 500) ? kNetworkErrorCode : sc;

      if (e.response?.data.runtimeType == String) {
        return Response(
          statusCode: effectiveCode,
          statusMessage: e.response?.statusMessage ?? 'NULL',
          data: apiResponse(
            message:
                e.response?.data ??
                'Something went wrong. Please try again later',
            data: {
              'error': true,
              'message': 'Something went wrong. Please try again later',
              'details': e.response?.data,
            },
          ),
          requestOptions: RequestOptions(path: ''),
        );
      }

      if (e.response?.data?['message'] is List) {
        return Response(
          statusCode: effectiveCode,
          statusMessage: e.response?.statusMessage ?? 'NULL',
          data: apiResponse(
            message:
                (e.response?.data?['message'] as List?)?.join(', ') ??
                'Something went wrong. Please try again later',
            data: e.response?.data,
          ),
          requestOptions: RequestOptions(path: ''),
        );
      }

      return Response(
        statusCode: effectiveCode,
        statusMessage: e.response?.statusMessage ?? 'NULL',
        data: apiResponse(
          message:
              e.response?.data?['message'] ??
              'Something went wrong. Please try again later',
          data: e.response?.data,
        ),
        requestOptions: RequestOptions(path: ''),
      );
  }
}
