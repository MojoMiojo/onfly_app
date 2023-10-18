import 'package:onfly_app/domain/utils/result.dart';
import 'package:onfly_app/domain/home/model/model.dart';

abstract class ExpenseRepository {
  Future<Result<ExpenseModel, Exception>> updateExpense(
    LoginModel loginModel,
    ExpenseModel expenseModel,
  );

  Future<Result<ExpenseModel, Exception>> createExpense(
    LoginModel loginModel,
    ExpenseModel expenseModel,
  );
}
