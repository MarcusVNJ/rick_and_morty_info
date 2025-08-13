import 'http_response.dart';

abstract class IHttpClient {
  Future<HttpResponse<T>> get<T>(
      String path, {
        Map<String, String>? headers,
        Map<String, dynamic>? queryParameters,
      });

  Future<HttpResponse<T>> post<T>(
      String path, {
        dynamic data,
        Map<String, String>? headers,
        Map<String, dynamic>? queryParameters,
      });
}
