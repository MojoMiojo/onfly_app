import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:onfly_app/data/utils/exceptions/map_value_exception.dart';
import 'package:onfly_app/data/utils/exceptions/response_exception.dart';

extension ExceptionExtension on Exception {
  void debugPrint() {
    var msg = 'Unexpected exception';

    if (this is MapValueException) {
      msg = "Fail to parse json";
    }
    if (this is ResponseException) {
      msg = "Received param isn't a Map<String, dynamic>";
    }

    if (this is DioException) {
      msg = toString();
    }

    if (kDebugMode) {
      print('A exception occured: $msg');
    }
  }
}
