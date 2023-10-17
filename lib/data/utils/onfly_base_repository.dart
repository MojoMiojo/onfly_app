import 'package:onfly_app/data/data.dart';
import 'package:onfly_app/data/utils/exceptions/unknown_exception.dart';
import 'package:onfly_app/data/utils/extensions/exception_extension.dart';

abstract class OnflyBaseRepository {
  Result<T, Exception> handleFailure<T>({
    dynamic error,
    StackTrace? trace,
  }) {
    if (error is Exception) {
      error.debugPrint();
      return Result.failure(error);
    } else {
      var unknownException = UnkownException();
      unknownException.debugPrint();
      return Result.failure(unknownException);
    }
  }
}
