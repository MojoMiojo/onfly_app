// import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:onfly_app/data/api/dio_client.dart';

class ApiHandler {
  final DioClient client;

  const ApiHandler({
    required this.client,
  });

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    
    final response = await client.dio.get(
      path,
      queryParameters: queryParams,
    );

    logRequest(
      baseUrl: response.requestOptions.baseUrl,
      path: path,
      data: response.data,
      statusMessage: response.statusMessage,
      statusCode: response.statusCode,
    );

    return response.data;
  }

  Future<dynamic> post({
    required String path,
    required dynamic body,
    Map<String, dynamic>? queryParams,
  }) async {

    final response = await client.dio.post(
      path,
      data: body,
      queryParameters: queryParams,
    );

    logRequest(
      baseUrl: response.requestOptions.baseUrl,
      path: path,
      data: response.data,
      statusMessage: response.statusMessage,
      statusCode: response.statusCode,
    );

    return response.data;
  }

  void logRequest({
    required String baseUrl,
    required String path,
    dynamic data,
    String? statusMessage,
    int? statusCode,
  }) {
    debugPrint(
      'ApiHandler | [$statusCode] $baseUrl$path, statusMessage: $statusMessage, data: $data',
    );
  }

  void debugPrint(dynamic data) {
    if (kDebugMode) {
      print(data);
    }
  }
}
