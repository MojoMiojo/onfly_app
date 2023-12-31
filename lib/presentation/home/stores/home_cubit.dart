import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/domain/expense/use_cases/create_expense_use_case.dart';
import 'package:onfly_app/domain/expense/use_cases/update_expense_use_case.dart';
import 'package:onfly_app/domain/home/model/model.dart';
import 'package:onfly_app/domain/home/use_cases/delete_expense_use_case.dart';
import 'package:onfly_app/domain/home/use_cases/list_expenses_use_case.dart';
import 'package:onfly_app/domain/home/use_cases/set_jwt_use_case.dart';
import 'package:onfly_app/domain/home/use_cases/use_cases.dart';
import 'package:onfly_app/domain/shared/use_cases/get_persisted_expenses_use_case.dart';
import 'package:onfly_app/domain/shared/use_cases/remove_persisted_expense_use_case.dart';
import 'package:onfly_app/domain/utils/onfly_base_use_case.dart';
import 'package:onfly_app/presentation/home/stores/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final SetJwtUseCase _setJwtUseCase;
  final AuthenticateUseCase _authenticateUseCase;
  final ListExpensesUseCase _listExpensesUseCase;
  final DeleteExpenseUseCase _deleteExpenseUseCase;
  final GetPersistedExpensesUseCase _getPersistedExpensesUseCase;
  final RemovePersistedExpenseUseCase _removePersistedExpenseUseCase;
  final CreateExpenseUseCase _createExpenseUseCase;
  final UpdateExpenseUseCase _updateExpenseUseCase;

  List<ExpenseModel> _expenses = [];

  final LoginModel _loginModel = LoginModel(
    identity: 'ccObDnaf',
    password: 'OSNCJld0',
  );

  bool _isAuthenticated = false;

  HomeCubit({
    required SetJwtUseCase setJwtUseCase,
    required AuthenticateUseCase authenticateUseCase,
    required ListExpensesUseCase listExpensesUseCase,
    required DeleteExpenseUseCase deleteExpenseUseCase,
    required GetPersistedExpensesUseCase getPersistedExpensesUseCase,
    required RemovePersistedExpenseUseCase removePersistedExpenseUseCase,
    required CreateExpenseUseCase createExpenseUseCase,
    required UpdateExpenseUseCase updateExpenseUseCase,
  })  : _setJwtUseCase = setJwtUseCase,
        _authenticateUseCase = authenticateUseCase,
        _listExpensesUseCase = listExpensesUseCase,
        _deleteExpenseUseCase = deleteExpenseUseCase,
        _getPersistedExpensesUseCase = getPersistedExpensesUseCase,
        _removePersistedExpenseUseCase = removePersistedExpenseUseCase,
        _createExpenseUseCase = createExpenseUseCase,
        _updateExpenseUseCase = updateExpenseUseCase,
        super(HomeInitialState());

  void fetch() async {
    await _authenticate();
    await _listExpenses();
    await _listPersistedExpenses();
  }

  Future<void> _authenticate() async {
    emit(HomeLoadingState());
    final response = await _authenticateUseCase(_loginModel);

    response.processResult(
      onSuccess: (authenticateToken) {
        _setJwtUseCase(authenticateToken);
        _isAuthenticated = true;
      },
      onFailure: (_) {},
    );
  }

  Future<void> _listExpenses() async {
    final response = await _listExpensesUseCase(_loginModel);

    response.processResult(
      onSuccess: (expenses) {
        _expenses = expenses;
        emit(HomeLoadedState(_expenses, _isAuthenticated));
      },
      onFailure: (_) => emit(HomeErrorState()),
    );
  }

  Future<void> _listPersistedExpenses() async {
    final response = await _getPersistedExpensesUseCase(NoParams());

    response.processResult(
      onSuccess: (expenses) {
        for (var element in _expenses) {
          if (!_expenses.contains(element)) {
            _expenses.add(element);
          }
        }
        emit(HomeLoadedState(_expenses, _isAuthenticated));
      },
      onFailure: (_) {},
    );
  }

  void updateExpenseCallback(ExpenseModel expense) {
    _expenses[_expenses.indexWhere((e) => e.id == expense.id)] = expense;
    emit(HomeLoadedState(_expenses, _isAuthenticated));

  }

  void createExpenseCallback(ExpenseModel expense) {
    _expenses.add(expense);
    emit(HomeLoadedState(_expenses, _isAuthenticated));

  }

  Future<void> deleteExpense(ExpenseModel model) async {
    if (!model.isSubmitted) return _deletePersistedExpense(model.id);
    
    emit(HomeLoadingState());

    var response = await _deleteExpenseUseCase(
      DeleteExpenseParams(
        _loginModel,
        model.id,
      ),
    );

    response.processResult(
      onSuccess: (_) {
        _expenses.removeWhere((element) => element.id == model.id);
        emit(HomeLoadedState(_expenses, _isAuthenticated));

      },
      onFailure: (_) => emit(HomeErrorState()),
    );
  }

  Future<void> _deletePersistedExpense(String id) async {
    emit(HomeLoadingState());

    var response = await _removePersistedExpenseUseCase(id);

    response.processResult(
      onSuccess: (_) {
        _expenses.removeWhere((element) => element.id == id);
        emit(HomeLoadedState(_expenses, _isAuthenticated));

      },
      onFailure: (_) => emit(HomeErrorState()),
    );
  }

  Future<void> syncExpense(ExpenseModel expense) async {
    if (!_isAuthenticated) await _authenticate();
    if (!expense.isSubmitted && expense.isEditPending) {
      return _syncEditedExpense(expense);
    }
    emit(HomeLoadingState());

    var response = await _createExpenseUseCase(
      CreateExpenseParams(
        _loginModel,
        expense,
      ),
    );

    response.processResult(
      onSuccess: (syncedExpense) {
        _expenses[_expenses.indexWhere((e) => e.id == expense.id)] =
            syncedExpense;
        _deletePersistedExpense(expense.id);
      },
      onFailure: (onFailure) => emit(HomeErrorState()),
    );
  }

  Future<void> _syncEditedExpense(ExpenseModel expense) async {
    if (!_isAuthenticated) await _authenticate();
    emit(HomeLoadingState());

    var response = await _updateExpenseUseCase(
      UpdateExpenseParams(
        _loginModel,
        expense,
      ),
    );

    response.processResult(
      onSuccess: (expense) {
        _expenses[_expenses.indexWhere((e) => e.id == expense.id)] = expense;
        emit(HomeLoadedState(_expenses, _isAuthenticated));
      },
      onFailure: (onFailure) => emit(HomeErrorState()),
    );
  }

  void tryAuth() async {
    await _authenticate();
    emit(HomeLoadedState(_expenses, _isAuthenticated));
  }

}
