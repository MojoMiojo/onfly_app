import 'package:onfly_app/domain/home/model/expense_model.dart';
import 'package:onfly_app/domain/shared/repository/shared_preferences_repository.dart';
import 'package:onfly_app/domain/utils/onfly_base_use_case.dart';
import 'package:onfly_app/domain/utils/result.dart';

class GetPersistedExpensesUseCase
    extends OnflyBaseUseCase<List<ExpenseModel>, NoParams> {
  final SharedPreferencesRepository _sharedPreferencesRepository;

  GetPersistedExpensesUseCase(this._sharedPreferencesRepository);

  @override
  Future<Result<List<ExpenseModel>, Exception>> call(NoParams params) async {
    return await _sharedPreferencesRepository.readAllExpenses();
  }
}
