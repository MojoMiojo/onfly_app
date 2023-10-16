import 'package:onfly_app/data/utils/exceptions/response_exception.dart';
import 'package:onfly_app/data/utils/extensions/map_extension.dart';
import 'package:onfly_app/domain/home/model/model.dart';

extension AuthenticateTokenDTO on AuthenticateTokenModel {
  static AuthenticateTokenModel fromData(dynamic response) {
    if (response is! Map<String, dynamic>) throw ResponseException();
    return AuthenticateTokenModel(token: response.getValue(key: 'token'));
  }
}
