import 'package:onfly_app/data/api/onfly_api_routes.dart';
import 'package:onfly_app/domain/api/api_handler.dart';

class HomeDatasource {
  final ApiHandler client;

  HomeDatasource(this.client);

  Future<dynamic> authenticate(dynamic body) async {
    return await client.post(
      path: OnflyApiRoutes.authenticate,
      body: body,
    );
  }
}
