import 'package:flutter/material.dart';
import 'package:onfly_app/data/api/dio_client.dart';

class ApiHandler {
  final DioClient client;

  const ApiHandler({
    required this.client,
  });

  Future<dynamic> get(String path) async {
    final response = await client.dio.get(path);

    logRequest(
      path: path,
      data: response.data,
      statusMessage: response.statusMessage,
      statusCode: response.statusCode,
    );

    return response;
  }

  Future<dynamic> post({
    required String path,
    required dynamic body,
    Map<String, dynamic>? queryParams,
  }) async {
    late dynamic response;

    response = await client.dio.post(
      path,
      data: body,
      queryParameters: queryParams,
    );

    return response;
  }

  void logRequest({
    required String path,
    dynamic data,
    String? statusMessage,
    int? statusCode,
  }) {
    debugPrint(
      'ApiHandler > path: [$statusCode]$path, statusMessage: $statusMessage, data: $data',
    );
  }
}
