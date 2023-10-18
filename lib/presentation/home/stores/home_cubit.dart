import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/domain/home/model/model.dart';
import 'package:onfly_app/domain/home/use_cases/delete_expense_use_case.dart';
import 'package:onfly_app/domain/home/use_cases/list_expenses_use_case.dart';
import 'package:onfly_app/domain/home/use_cases/set_jwt_use_case.dart';
import 'package:onfly_app/domain/home/use_cases/use_cases.dart';
import 'package:onfly_app/presentation/home/stores/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final SetJwtUseCase _setJwtUseCase;
  final AuthenticateUseCase _authenticateUseCase;
  final ListExpensesUseCase _listExpensesUseCase;
  final DeleteExpenseUseCase _deleteExpenseUseCase;

  List<ExpenseModel>? _expenses;

  final LoginModel _loginModel = LoginModel(
    identity: 'ccObDnaf',
    password: 'OSNCJld0',
  );

  HomeCubit({
    required SetJwtUseCase setJwtUseCase,
    required AuthenticateUseCase authenticateUseCase,
    required ListExpensesUseCase listExpensesUseCase,
    required DeleteExpenseUseCase deleteExpenseUseCase,
  })  : _setJwtUseCase = setJwtUseCase,
        _authenticateUseCase = authenticateUseCase,
        _listExpensesUseCase = listExpensesUseCase,
        _deleteExpenseUseCase = deleteExpenseUseCase,
        super(HomeInitialState());

  void fetch() async {
    emit(HomeLoadingState());
    await authenticate();
    await listExpenses();
  }

  Future<void> authenticate() async {
   
    final response = await _authenticateUseCase(_loginModel);

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
      onSuccess: (expenses) {
        _expenses = expenses;
        emit(HomeLoadedState(expenses));
      },
      onFailure: (_) => emit(HomeErrorState()),
    );
  }

  void updateExpenseCallback(ExpenseModel expense) {
    _expenses![_expenses!.indexWhere((e) => e.id == expense.id)] = expense;
    emit(HomeLoadedState(_expenses!));
  }

  void createExpenseCallback(ExpenseModel expense) {
    _expenses!.add(expense);
    emit(HomeLoadedState(_expenses!));
  }

  Future<void> deleteExpense(String id) async {
    emit(HomeLoadingState());

    var response = await _deleteExpenseUseCase(
      DeleteExpenseParams(
        _loginModel,
        id,
      ),
    );

    response.processResult(
      onSuccess: (_) {
        _expenses!.removeWhere((element) => element.id == id);
        emit(HomeLoadedState(_expenses!));
      },
      onFailure: (_) => emit(HomeErrorState()),
    );
  }

}
