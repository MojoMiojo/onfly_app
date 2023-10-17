import 'package:onfly_app/domain/home/model/model.dart';
import 'package:onfly_app/domain/home/repository/home_repository.dart';
import 'package:onfly_app/domain/utils/onfly_base_use_case.dart';
import 'package:onfly_app/domain/utils/result.dart';

class AuthenticateUseCase
    implements OnflyBaseUseCase<AuthenticateTokenModel, Param> {
  final HomeRepository _homeRepository;

  AuthenticateUseCase(this._homeRepository);
  @override
  Future<Result<AuthenticateTokenModel, Exception>> call(Param params) async {
    return await _homeRepository.authenticate(params.loginModel);
  }
}

class Param {
  final LoginModel loginModel;
  Param(this.loginModel);
}
