import 'package:onfly_app/domain/shared/repository/shared_preferences_repository.dart';
import 'package:onfly_app/domain/utils/onfly_base_use_case.dart';
import 'package:onfly_app/domain/utils/result.dart';

class RemovePersistedExpenseUseCase implements OnflyBaseUseCase<bool, String> {
  final SharedPreferencesRepository _sharedPreferencesRepository;

  RemovePersistedExpenseUseCase(this._sharedPreferencesRepository);

  @override
  Future<Result<bool, Exception>> call(String id) async {
    return await _sharedPreferencesRepository.removeExpense(id);
  }
}
