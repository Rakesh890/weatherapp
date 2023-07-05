import 'package:http/src/response.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;
import '../interceptoer/api_intercepter.dart';
import '../network_interface/api_service_interface.dart';

class ApiServices extends ApiServiceInterface {
  var client = http.Client();
  final headers = {
    'Content-Type': 'application/json',
  };
  @override
  Future<Response> executeGet({required String url}) async {
    client = InterceptedClient.build(interceptors: [ApiInterceptor()]);
    final response = await client.get(
      Uri.parse(url),
    );
    return response;
  }

  @override
  Future<Response> executePost(
      {required String url, required Map bodyrequest}) async {
    client = InterceptedClient.build(interceptors: [ApiInterceptor()]);
    final response = await client.post(Uri.parse(url), body: bodyrequest);
    return response;
  }
}
