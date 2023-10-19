import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onfly_app/domain/expense/use_cases/create_expense_use_case.dart';
import 'package:onfly_app/domain/expense/use_cases/update_expense_use_case.dart';
import 'package:onfly_app/domain/home/model/expense_model.dart';
import 'package:onfly_app/domain/home/model/login_model.dart';
import 'package:onfly_app/domain/shared/use_cases/persist_expense_use_case.dart';
import 'package:onfly_app/presentation/expense/stores/expense_state.dart';
import 'package:onfly_app/presentation/presentation.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final UpdateExpenseUseCase _updateExpenseUseCase;
  final CreateExpenseUseCase _createExpenseUseCase;
  final PersistExpenseUseCase _persistExpenseUseCase;
  
  ExpenseModel? _expenseModel;

  ExpenseCubit({
    required UpdateExpenseUseCase updateExpenseUseCase,
    required CreateExpenseUseCase createExpenseUseCase,
    required PersistExpenseUseCase persistExpenseUseCase,

  })  : _updateExpenseUseCase = updateExpenseUseCase,
        _createExpenseUseCase = createExpenseUseCase,
        _persistExpenseUseCase = persistExpenseUseCase,
        super(ExpenseInitialState());

  final TextEditingController _description = TextEditingController();
  final TextEditingController _expenseDate = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  void fetch({ExpenseModel? expenseModel}) {
    if (expenseModel != null) _initFields(expenseModel);

    _expenseModel = expenseModel;

    emitLoadedState();
  }

  void _initFields(ExpenseModel expenseModel) {
    _description.text = expenseModel.description;
    _expenseDate.text = expenseModel.asDate.brazillianDateFormat();
    _amount.text = expenseModel.amount.toDouble().formatToMoney(symbol: '');
  }

  void emitLoadedState() {
    emit(ExpenseLoadedState(
      description: _description,
      expenseDate: _expenseDate,
      amount: _amount,
    ));
  }

  Future<void> updateExpense(Function(ExpenseModel expense) onSuccess) async {
    emit(ExpenseLoadingState());

    var params = UpdateExpenseParams(
      LoginModel(identity: 'ccObDnaf', password: ''),
      _expenseModel!.copyWith(
        description: _description.text,
        expenseDate: DateTime.now().toString(),
        amount: double.parse(_amount.text),
      ),
    );

    var response = await _updateExpenseUseCase(params);

    response.processResult(
      onSuccess: (expense) => onSuccess(expense),
      onFailure: (_) => emit(ExpenseErrorState()),
    );
  }

  Future<void> createExpense(
    Function(ExpenseModel expense) createExpenseCallback,
  ) async {
    emit(ExpenseLoadingState());

    final expense = ExpenseModel.create(
      description: _description.text,
      expenseDate: DateTime.now().toString(),
      amount: double.parse(_amount.text),
      isSubmitted: false,
    );

    var params = CreateExpenseParams(
      LoginModel(identity: 'ccObDnaf', password: ''),
      ExpenseModel.create(
        description: _description.text,
        expenseDate: DateTime.now().toString(),
        amount: double.parse(_amount.text),
        isSubmitted: false,
      ),
    );

    var response = await _createExpenseUseCase(params);

    response.processResult(
      onSuccess: (expense) => createExpenseCallback(expense),
      onFailure: (_) async {
        var wasPersisted = await _persistExpense(expense);
        if (wasPersisted) createExpenseCallback(expense);
      },
    );
  }

  Future<bool> _persistExpense(ExpenseModel expense) async {
    emit(ExpenseLoadingState());
    bool isSuccess = false;

    var response = await _persistExpenseUseCase(expense);

    response.processResult(
      onSuccess: (onSuccess) => isSuccess = onSuccess,
      onFailure: (_) => emit(ExpenseErrorState()),
    );

    return isSuccess;
  }

}
