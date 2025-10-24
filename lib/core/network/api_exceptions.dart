import 'package:dio/dio.dart';
import 'package:hangry_app/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handlError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    if (statusCode != null && data is Map<String, dynamic>) {
      return ApiError(message: data['message'], code: statusCode);
    }
    if (statusCode == 302) {
      throw ApiError(message: 'the email alredy taken');
    }
    switch (error.type) {
      case DioExceptionType.cancel:
        return ApiError(message: "Request to API server was cancelled");
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Connection timeout with API server");
      case DioExceptionType.receiveTimeout:
        return ApiError(
          message: "Receive timeout in connection with API server",
        );
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Send timeout in connection with API server");
      case DioExceptionType.badResponse:
        return ApiError(message: 'Invalid credentials ');
      case DioExceptionType.connectionError:
        return ApiError(message: "No Internet connection");
      case DioExceptionType.badCertificate:
        return ApiError(message: "Bad certificate");
      default:
        return ApiError(message: "Unexpected error occurred");
    }
  }
}
