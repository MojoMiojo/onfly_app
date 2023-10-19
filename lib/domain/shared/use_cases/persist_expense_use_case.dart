import 'package:onfly_app/domain/home/model/expense_model.dart';
import 'package:onfly_app/domain/shared/repository/shared_preferences_repository.dart';
import 'package:onfly_app/domain/utils/onfly_base_use_case.dart';
import 'package:onfly_app/domain/utils/result.dart';

class PersistExpenseUseCase implements OnflyBaseUseCase<bool, ExpenseModel> {
  final SharedPreferencesRepository _sharedPreferencesRepository;

  PersistExpenseUseCase(this._sharedPreferencesRepository);

  @override
  Future<Result<bool, Exception>> call(ExpenseModel expenseModel) async {
    return await _sharedPreferencesRepository.writeExpense(expenseModel);
  }
}
