import 'package:onfly_app/data/api/result.dart';
import 'package:onfly_app/domain/home/model/model.dart';

abstract class HomeRepository {
  Future<Result<AuthenticateTokenModel>> authenticate(LoginModel loginModel);
}
