import 'package:onfly_app/domain/utils/result.dart';
import 'package:onfly_app/domain/home/model/model.dart';

abstract class HomeRepository {
  Future<Result<AuthenticateTokenModel, Exception>> authenticate(
    LoginModel loginModel,
  );

  Future<Result<List<ExpenseModel>, Exception>> listExpenses(
    LoginModel loginModel,
  );
}
