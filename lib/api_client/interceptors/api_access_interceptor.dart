import 'package:dio/dio.dart';

class ApiAccessInterceptor extends Interceptor {
  final _key = '';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(
      options..queryParameters.addAll({'access_key': _key}),
      handler,
    );
  }
}
