import 'package:dio/dio.dart';
import 'package:flutter_pokemon/data/models/app_error.dart';

class ApiHelper {
  static Future<T> handleErrors<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw AppError(
            'Connection timed out', e.response?.statusCode, ErrorType.timeout);
      } else if (e.type == DioExceptionType.badResponse) {
        throw AppError(
            'Server error', e.response?.statusCode, ErrorType.server);
      } else {
        throw AppError('Network error', null, ErrorType.network);
      }
    } catch (e) {
      throw AppError('An unexpected error occurred', null, ErrorType.general);
    }
  }
}
