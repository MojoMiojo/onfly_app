import 'package:onfly_app/domain/home/model/expense_model.dart';
import 'package:onfly_app/domain/utils/result.dart';

abstract class SharedPreferencesRepository {
  Future<Result<bool, Exception>> writeExpense(ExpenseModel expenseModel);

  Future<Result<bool, Exception>> removeExpense(String id);

  Future<Result<List<ExpenseModel>, Exception>> readAllExpenses();
}
