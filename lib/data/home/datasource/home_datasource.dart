import 'package:onfly_app/data/data.dart';

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
