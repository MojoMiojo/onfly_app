import 'package:onfly_app/domain/home/model/model.dart';
import 'package:onfly_app/domain/home/repository/home_repository.dart';
import 'package:onfly_app/domain/utils/onfly_base_use_case.dart';
import 'package:onfly_app/domain/utils/result.dart';

class ListExpensesUseCase
    implements OnflyBaseUseCase<List<ExpenseModel>, LoginModel> {
  final HomeRepository _homeRepository;

  ListExpensesUseCase(this._homeRepository);

  @override
  Future<Result<List<ExpenseModel>, Exception>> call(
      LoginModel loginModel) async {
    return await _homeRepository.listExpenses(loginModel);
  }
}
