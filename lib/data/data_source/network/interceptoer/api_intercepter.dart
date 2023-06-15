import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class ApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers['Content-Type'] = 'application/json';
    if (kDebugMode) {
      print('REQUEST : ${data.method} : ${data.url}');
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (kDebugMode) {
      print('RESPONSE : ${data.statusCode}');
    }
    return data;
  }
}
