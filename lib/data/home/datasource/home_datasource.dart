import 'package:onfly_app/data/api/onfly_api_routes.dart';
import 'package:onfly_app/domain/api/api_handler.dart';

class HomeDatasource {
  final ApiHandler _client;

  HomeDatasource(this._client);

  Future<dynamic> authenticate(dynamic body) async {
    return await _client.post(
      path: OnflyApiRoutes.authenticate,
      body: body,
    );
  }

  Future<dynamic> listExpenses(dynamic login) async {
    return await _client.get(
      path: OnflyApiRoutes(login).createOrlistExpenses,
    );
  }

  Future<dynamic> deleteExpense(dynamic identity, dynamic pathVariables) async {
    return await _client.delete(
      path: OnflyApiRoutes(
        identity,
        pathVariables: pathVariables,
      ).updateExpense,
    );
  }
}
