import 'package:dio/dio.dart';
import 'package:opticash/core/api/endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    final dioOptions = BaseOptions(
      baseUrl: Endpoints.baseUrl,
      responseType: ResponseType.json,
    );

    final logInterceptor = PrettyDioLogger(
      requestBody: true,
      responseBody: true,
      error: true,
      request: true,
      requestHeader: true,
      responseHeader: false,
      maxWidth: 120,
    );

    _dio = Dio(dioOptions);
    _dio.interceptors.add(logInterceptor);
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? param,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(endpoint, data: data, queryParameters: param);
      return {
        'success': successCodes.containsKey(response.statusCode),
        'data': response.data,
        'statusCode': response.statusCode,
      };
    } catch (e) {
      rethrow;
    }
  }
}

const successCodes = <int, String>{
  200: "OK",
  201: "Created",
  202: "Accepted",
  203: "Non-Authoritative Information",
  204: "No Content",
  205: "Reset Content",
  206: "Partial Content",
  207: "Multi-Status",
  208: "Already Reported",
  226: "IM Used"
};
