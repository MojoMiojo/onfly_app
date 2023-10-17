import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/domain/home/model/model.dart';
import 'package:onfly_app/domain/home/use_cases/set_jwt_use_case.dart';
import 'package:onfly_app/domain/home/use_cases/use_cases.dart';
import 'package:onfly_app/presentation/home/stores/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final SetJwtUseCase _setJwtUseCase;
  final AuthenticateUseCase _authenticateUseCase;

  HomeCubit({
    required SetJwtUseCase setJwtUseCase,
    required AuthenticateUseCase authenticateUseCase,
  })  : _setJwtUseCase = setJwtUseCase,
        _authenticateUseCase = authenticateUseCase,
        super(HomeInitialState());

  void fetch() async {
    await authenticate();
  }

  Future<void> authenticate() async {
    emit(HomeLoadingState());

    final param = Param(
      LoginModel(
        identity: 'ccObDnaf',
        password: 'OSNCJld0',
      ),
    );

    final response = await _authenticateUseCase(param);

    response.processResult(
      onSuccess: (authenticateToken) {
        _setJwtUseCase(authenticateToken);
        emit(
          HomeLoadedState(mockedExpenses),
        );
      },
      onFailure: (_) => emit(HomeErrorState()),
    );

  }

  final mockedExpenses = [
    ExpenseModel(
      title: 'Almoço',
      date: DateTime.now(),
      value: 45.13,
      isSubmitted: false,
    ),
    ExpenseModel(
      title: 'Almoço',
      date: DateTime.now(),
      value: 45.13,
      isSubmitted: false,
    ),
    ExpenseModel(
      title: 'Almoço',
      date: DateTime.now(),
      value: 45.13,
      isSubmitted: true,
    )
  ];
}
