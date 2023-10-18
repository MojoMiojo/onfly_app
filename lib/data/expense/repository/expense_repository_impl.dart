import 'package:onfly_app/data/expense/datasource/expense_datasource.dart';
import 'package:onfly_app/data/home/model/expense_dto.dart';
import 'package:onfly_app/data/utils/onfly_base_repository.dart';
import 'package:onfly_app/domain/expense/repository/expense_repository.dart';
import 'package:onfly_app/domain/home/model/expense_model.dart';
import 'package:onfly_app/domain/home/model/login_model.dart';
import 'package:onfly_app/domain/utils/result.dart';

class ExpenseRepositoryImpl extends OnflyBaseRepository
    implements ExpenseRepository {
  final ExpenseDatasource _datasource;

  ExpenseRepositoryImpl(this._datasource);

  @override
  Future<Result<ExpenseModel, Exception>> updateExpense(
    LoginModel loginModel,
    ExpenseModel expenseModel,
  ) async {
    try {
      final response = await _datasource.updateExpense(
        expenseModel.fromDomain(),
        loginModel.identity,
        expenseModel.id,
      );

      return Result.success(ExpenseDTO.fromData(response));
    } catch (e, t) {
      return handleFailure(error: e, trace: t);
    }
  }

  @override
  Future<Result<ExpenseModel, Exception>> createExpense(
    LoginModel loginModel,
    ExpenseModel expenseModel,
  ) async {
    try {
      final response = await _datasource.createExpense(
        expenseModel.fromDomain(),
        loginModel.identity,
      );

      return Result.success(ExpenseDTO.fromData(response));
    } catch (e, t) {
      return handleFailure(error: e, trace: t);
    }
  }
}
