import 'package:onfly_app/domain/home/model/login_model.dart';
import 'package:onfly_app/domain/home/repository/home_repository.dart';
import 'package:onfly_app/domain/utils/onfly_base_use_case.dart';
import 'package:onfly_app/domain/utils/result.dart';

class DeleteExpenseUseCase
    implements OnflyBaseUseCase<bool, DeleteExpenseParams> {
  final HomeRepository _homeRepository;

  DeleteExpenseUseCase(this._homeRepository);

  @override
  Future<Result<bool, Exception>> call(DeleteExpenseParams params) async {
    return await _homeRepository.deleteExpense(
      params.loginModel,
      params.id,
    );
  }
}

class DeleteExpenseParams {
  final LoginModel loginModel;
  final String id;

  DeleteExpenseParams(this.loginModel, this.id);
}
