import 'dart:async';
import 'package:currency_converter/api_client/models/api_response.dart';

class ApiRequest<T>{
  ApiRequest(this._operation);


  final Future<ApiResponse<T>> _operation;

  Future<R> then<R>(FutureOr<R> Function(T payload) onResponse){
    return _operation.then((response) => response.convert(onResponse));
  }
}
