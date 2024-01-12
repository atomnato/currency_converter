import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  const ApiResponse._();
  const factory ApiResponse.success(T payload) = _ApiSuccessResponse;

  const factory ApiResponse.error(Object error, [dynamic payload]) =
      _ApiErrorResponse;

  R convert<R extends Object?>(
    R Function(T payload) converter, {
    R Function(Object error)? error,
  }) {
    return when(
      success: converter,
      error: (apiError, payload) {
        if (error != null) return error(apiError);

        // ignore: only_throw_errors
        throw apiError;
      },
    );
  }
}
