import 'package:dio/dio.dart';

import 'api_exception.dart';

/// Thin wrapper around [Dio] used by feature `services` (the data-source
/// layer) to talk to the ALLCURO backend. Centralising it here means base
/// URL, headers and error mapping only live in one place.
class ApiClient {
  final Dio _dio;

  ApiClient({String baseUrl = 'https://api.allcuro.example.com', Dio? dio})
    : _dio = dio ??
          Dio(
            BaseOptions(
              baseUrl: baseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) {
    return _run(() => _dio.get<T>(path, queryParameters: queryParameters));
  }

  Future<Response<T>> post<T>(String path, {Object? data}) {
    return _run(() => _dio.post<T>(path, data: data));
  }

  Future<Response<T>> put<T>(String path, {Object? data}) {
    return _run(() => _dio.put<T>(path, data: data));
  }

  Future<Response<T>> delete<T>(String path) {
    return _run(() => _dio.delete<T>(path));
  }

  Future<Response<T>> _run<T>(Future<Response<T>> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw ApiException(
        e.message ?? 'Network request failed',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
