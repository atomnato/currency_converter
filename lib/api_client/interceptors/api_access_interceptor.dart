import 'package:dio/dio.dart';

class ApiAccessInterceptor extends Interceptor {
  final _key = '2a34fc40fc5e0f6739bf68dbcb2ec1d9';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(
      options..queryParameters.addAll({'access_key': _key}),
      handler,
    );
  }
}
