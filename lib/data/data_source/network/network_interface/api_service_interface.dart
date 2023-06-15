import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class ApiServiceInterface {
  Future<http.Response> executeGet({required String url});
  Future<http.Response> executePost(
      {required String url, required Map bodyrequest});
}
