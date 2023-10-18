import 'package:onfly_app/domain/expense/repository/expense_repository.dart';
import 'package:onfly_app/domain/home/model/expense_model.dart';
import 'package:onfly_app/domain/home/model/login_model.dart';
import 'package:onfly_app/domain/utils/onfly_base_use_case.dart';
import 'package:onfly_app/domain/utils/result.dart';

class UpdateExpenseUseCase
    implements OnflyBaseUseCase<ExpenseModel, UpdateExpenseParams> {
  final ExpenseRepository _expenseRepository;

  UpdateExpenseUseCase(this._expenseRepository);

  @override
  Future<Result<ExpenseModel, Exception>> call(
      UpdateExpenseParams params) async {
    return await _expenseRepository.updateExpense(
        params.loginModel, params.expenseModel);
  }
}

class UpdateExpenseParams {
  final LoginModel loginModel;
  final ExpenseModel expenseModel;

  UpdateExpenseParams(this.loginModel, this.expenseModel);
}
