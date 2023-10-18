import 'package:onfly_app/domain/expense/repository/expense_repository.dart';
import 'package:onfly_app/domain/home/model/model.dart';
import 'package:onfly_app/domain/utils/onfly_base_use_case.dart';
import 'package:onfly_app/domain/utils/result.dart';

class CreateExpenseUseCase
    implements OnflyBaseUseCase<ExpenseModel, CreateExpenseParams> {
  final ExpenseRepository _expenseRepository;

  CreateExpenseUseCase(this._expenseRepository);

  @override
  Future<Result<ExpenseModel, Exception>> call(
      CreateExpenseParams params) async {
    return await _expenseRepository.createExpense(
      params.loginModel,
      params.expenseModel,
    );
  }
}

class CreateExpenseParams {
  final LoginModel loginModel;
  final ExpenseModel expenseModel;

  CreateExpenseParams(this.loginModel, this.expenseModel);
}
