import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/domain/home/model/model.dart';
import 'package:onfly_app/domain/home/use_cases/list_expenses_use_case.dart';
import 'package:onfly_app/domain/home/use_cases/set_jwt_use_case.dart';
import 'package:onfly_app/domain/home/use_cases/use_cases.dart';
import 'package:onfly_app/presentation/home/stores/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final SetJwtUseCase _setJwtUseCase;
  final AuthenticateUseCase _authenticateUseCase;
  final ListExpensesUseCase _listExpensesUseCase;

  final LoginModel _loginModel = LoginModel(
    identity: 'ccObDnaf',
    password: 'OSNCJld0',
  );

  HomeCubit({
    required SetJwtUseCase setJwtUseCase,
    required AuthenticateUseCase authenticateUseCase,
    required ListExpensesUseCase listExpensesUseCase,
  })  : _setJwtUseCase = setJwtUseCase,
        _authenticateUseCase = authenticateUseCase,
        _listExpensesUseCase = listExpensesUseCase,
        super(HomeInitialState());

  void fetch() async {
    emit(HomeLoadingState());
    await authenticate();
    await listExpenses();
  }

  Future<void> authenticate() async {
   
    final response = await _authenticateUseCase(_loginModel
    );

    response.processResult(
      onSuccess: (authenticateToken) {
        _setJwtUseCase(authenticateToken);
      },
      onFailure: (_) => emit(HomeErrorState()),
    );
  }

  Future<void> listExpenses() async {
    final response = await _listExpensesUseCase(_loginModel);

    response.processResult(
      onSuccess: (expenses) => emit(HomeLoadedState(expenses)),
      onFailure: (_) => emit(HomeErrorState()),
    );
  }
}
