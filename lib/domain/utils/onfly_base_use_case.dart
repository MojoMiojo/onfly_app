import 'package:equatable/equatable.dart';
import 'package:onfly_app/data/data.dart';

abstract class OnflyBaseUseCase<T, Params> {
  Future<Result<T, Exception>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
