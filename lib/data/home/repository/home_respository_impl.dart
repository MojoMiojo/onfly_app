import 'package:onfly_app/data/home/model/expense_dto.dart';
import 'package:onfly_app/data/utils/onfly_base_repository.dart';
import 'package:onfly_app/domain/home/model/expense_model.dart';
import 'package:onfly_app/domain/utils/result.dart';
import 'package:onfly_app/data/home/datasource/home_datasource.dart';
import 'package:onfly_app/data/home/model/authenticate_token_dto.dart';
import 'package:onfly_app/data/home/model/login_dto.dart';
import 'package:onfly_app/domain/home/model/authenticate_token_model.dart';
import 'package:onfly_app/domain/home/model/login_model.dart';
import 'package:onfly_app/domain/home/repository/home_repository.dart';

class HomeRepositoryImpl extends OnflyBaseRepository implements HomeRepository {
  final HomeDatasource _datasource;

  HomeRepositoryImpl(this._datasource);

  @override
  Future<Result<AuthenticateTokenModel, Exception>> authenticate(
      LoginModel loginModel) async {
    try {
      final body = loginModel.fromDomain();

      final response = await _datasource.authenticate(body);

      return Result.success(AuthenticateTokenDTO.fromData(response));
    } catch (e, t) {
      return handleFailure(error: e, trace: t);
    }
  }

  @override
  Future<Result<List<ExpenseModel>, Exception>> listExpenses(
      LoginModel loginModel) async {
    try {
      final response = await _datasource.listExpenses(loginModel.identity);
      return Result.success(ExpenseDTO.fromDataList(response));
    } catch (e, t) {
      return handleFailure(error: e, trace: t);
    }
  }
  
  @override
  Future<Result<bool, Exception>> deleteExpense(
    LoginModel loginModel,
    String id,
  ) async {
    try {
      await _datasource.deleteExpense(loginModel.identity, id);
      return Result.success(true);
    } catch (e, t) {
      return handleFailure(error: e, trace: t);
    }
  }
}
