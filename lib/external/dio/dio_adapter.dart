import 'package:dio/dio.dart';
import 'package:rick_and_morty_info/core/error/request_failures.dart';
import 'package:rick_and_morty_info/core/http/http_client.dart';
import 'package:rick_and_morty_info/core/http/http_response.dart';

class DioAdapter implements IHttpClient {
  final Dio _dio;

  DioAdapter({required Dio dio}) : _dio = dio;

  HttpResponse<T> _handleResponse<T>(Response response) {
    return HttpResponse<T>(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  @override
  Future<HttpResponse<T>> get<T>(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse<T>(response);
    } on DioException catch (error) {
      _handleDioException(error);
    }
  }

  @override
  Future<HttpResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse<T>(response);
    } on DioException catch (error) {
      _handleDioException(error);
    }
  }

  Never _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == null) {
          throw UnknownError(
            message: 'Resposta de erro recebida sem código de status.',
          );
        }
        if (statusCode >= 500) {
          throw InternalServerError(errorCode: statusCode);
        } else {
          throw BadRequestError(errorCode: statusCode);
        }
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeOutError();
      case DioExceptionType.connectionError:
        throw NoConnectionError();
      case DioExceptionType.cancel:
        throw RequestCancelledError();
      case DioExceptionType.unknown:
      default:
        throw UnknownError(
          message: error.message ?? 'Ocorreu um erro desconhecido.',
        );
    }
  }
}
