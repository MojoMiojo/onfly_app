import 'package:dio/dio.dart';

class DioClient {
  late Dio dio;

  final String baseUrl = 'https://go-bd-api-3iyuzyysfa-uc.a.run.app/api';
  final connectTimeout = const Duration(seconds: 30);

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: _getHeaders(),
        connectTimeout: connectTimeout,
      ),
    );
  }

  Map<String, String> _getHeaders() {
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    return headers;
  }

  void setJwt(String jwt) {
    var headers = dio.options.headers;
    headers['Authorization'] = 'Bearer $jwt';
    dio.options.headers = headers;
  }
}
