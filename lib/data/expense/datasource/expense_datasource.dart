import 'package:onfly_app/data/api/onfly_api_routes.dart';
import 'package:onfly_app/domain/api/api_handler.dart';

class ExpenseDatasource {
  final ApiHandler _client;

  ExpenseDatasource(this._client);

  Future<dynamic> updateExpense(
      dynamic body, dynamic identity, dynamic pathVariables) async {
    return await _client.patch(
      path: OnflyApiRoutes(
        identity,
        pathVariables: pathVariables,
      ).updateExpense,
      body: body,
    );
  }
}
