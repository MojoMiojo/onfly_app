import 'package:onfly_app/domain/home/model/model.dart';

extension LoginDTO on LoginModel {
  Map<String, dynamic> fromDomain() {
    Map<String, dynamic> map = {};

    map['identity'] = identity;
    map['password'] = password;

    return map;
  }
}
