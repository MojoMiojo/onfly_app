abstract class ApiHandler {
  void setJwt(String jwt);

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParams,
  });

  Future<dynamic> post({
    required String path,
    required dynamic body,
    Map<String, dynamic>? queryParams,
  });

  Future<dynamic> patch({
    required String path,
    required dynamic body,
    Map<String, dynamic>? queryParams,
  });
}
