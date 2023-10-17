import 'package:onfly_app/domain/api/api_handler.dart';
import 'package:onfly_app/domain/home/model/model.dart';

class SetJwtUseCase {
  final ApiHandler apiHandler;

  SetJwtUseCase(this.apiHandler);

  void call(AuthenticateTokenModel jwtModel) {
    apiHandler.setJwt(jwtModel.token);
  }
}
