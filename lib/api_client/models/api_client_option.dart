import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_client_option.freezed.dart';

@freezed
class ApiClientOption with _$ApiClientOption {
  const factory ApiClientOption({
    required Uri endpoint,
    required Map<String, String>? headers,
  }) = _ApiClientOption;
}
