import 'package:currency_converter/api_client/interceptors/api_access_interceptor.dart';
import 'package:currency_converter/api_client/models/api_client_option.dart';
import 'package:currency_converter/api_client/models/api_error.dart';
import 'package:currency_converter/api_client/models/api_request.dart';
import 'package:currency_converter/api_client/models/api_response.dart';
import 'package:dio/dio.dart';

enum RequestContentType { json, formData }

typedef JsonObject = Map<String, dynamic>;

class DioClient {
  DioClient(ApiClientOption option)
      : _dio = Dio(
          BaseOptions(
            baseUrl: option.endpoint.toString(),
            headers: option.headers,
          ),
        )..interceptors.addAll([ApiAccessInterceptor()]);

  final Dio _dio;

  ApiRequest<T> request<T>({
    required String path,
    required String method,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    RequestContentType contentType = RequestContentType.json,
  }) {
    final cancelToken = CancelToken();
    final operation = Future<ApiResponse<T>>(() async {
      try {
        final response = await _dio.request<dynamic>(
          path,
          data: data,
          queryParameters: query,
          cancelToken: cancelToken,
          options: Options(
            method: method,
            headers: {
              Headers.contentTypeHeader: Headers.jsonContentType,
            },
            listFormat: ListFormat.multiCompatible,
          ),
        );

        return _parseResponse(response);
      } on ApiError {
        rethrow;
      } on DioException catch (error) {
        final apiError = error.response != null
            ? _errorHandler<dynamic>(error.response)
            : null;

        throw apiError ?? const ApiError.invalidResponse();
      } on Exception catch (_) {
        throw const ApiError.invalidResponse();
      }
    });

    return ApiRequest<T>(operation);
  }

  ApiRequest<T> get<T>({required String path, Map<String, dynamic>? query}) {
    return request(path: path, method: 'GET', query: query);
  }

  ApiRequest<T> post<T>({
    required String path,
    Map<String, dynamic>? data,
    RequestContentType contentType = RequestContentType.json,
  }) {
    return request(
      path: path,
      method: 'POST',
      data: data,
      contentType: contentType,
    );
  }

  ApiResponse<T> _parseResponse<T>(Response<dynamic> response) {
    final data = response.data;

    if (data is T) {
      return ApiResponse.success(data);
    }
    throw _errorHandler<T>(response);
  }

  ApiError _errorHandler<T>(Response<dynamic>? response) {
    if (response != null) {
      final data = response.data;

      if (data is JsonObject) {
        final message =
            (data is String && data.isNotEmpty ? data : null) as String?;

        if (response.statusCode == 400) {
          return ApiError.server(message);
        }
        if (response.statusCode == 401) {
          return ApiError.unauthorized(message);
        }
        if (response.statusCode == 403) {
          return ApiError.forbidden(message);
        }
        if (message != null) {
          return ApiError.server(message);
        }
      }
    }

    return const ApiError.noResponse();
  }
}
