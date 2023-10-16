import 'package:onfly_app/domain/home/model/model.dart';
import 'package:onfly_app/domain/utils/onfly_base_use_case.dart';
import 'package:onfly_app/domain/utils/result.dart';

class AuthenticateUseCase
    implements OnflyBaseUseCase<AuthenticateTokenModel, Param> {
  @override
  Future<Result<AuthenticateTokenModel>> call(Param params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class Param {}
