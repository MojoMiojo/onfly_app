import 'package:onfly_app/data/utils/onfly_base_repository.dart';
import 'package:onfly_app/domain/utils/result.dart';
import 'package:onfly_app/data/home/datasource/home_datasource.dart';
import 'package:onfly_app/data/home/model/authenticate_token_dto.dart';
import 'package:onfly_app/data/home/model/login_dto.dart';
import 'package:onfly_app/domain/home/model/authenticate_token_model.dart';
import 'package:onfly_app/domain/home/model/login_model.dart';
import 'package:onfly_app/domain/home/repository/home_repository.dart';

class HomeRepositoryImpl extends OnflyBaseRepository implements HomeRepository {
  final HomeDatasource _datasource;

  HomeRepositoryImpl(this._datasource);

  @override
  Future<Result<AuthenticateTokenModel, Exception>> authenticate(
      LoginModel loginModel) async {
    try {
      final body = loginModel.fromDomain();

      final response = await _datasource.authenticate(body);

      return Result.success(AuthenticateTokenDTO.fromData(response));
    } catch (e, t) {
      return handleFailure(error: e, trace: t);
    }
  }
}
