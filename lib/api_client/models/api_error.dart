import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';

@freezed
class ApiError with _$ApiError  implements Exception{
  const factory ApiError.server(String? message) = ApiServerError;
  const factory ApiError.unauthorized(String? message) = ApiUnauthorizedError;
  const factory ApiError.forbidden(String? message) = ApiForbiddenError;
  const factory ApiError.noResponse(String? message) = ApiNoResponseError;
  const factory ApiError.invalidResponse(String? message) = ApiInvalidResponseError;

}
