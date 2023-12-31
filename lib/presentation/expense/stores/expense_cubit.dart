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

  final GlobalKey<FormState> decriptionFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> expenseDateFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> amountFormKey = GlobalKey<FormState>();
  
  ExpenseModel? _expenseModel;

  void fetch({ExpenseModel? expenseModel}) {
    if (expenseModel != null) _initFields(expenseModel);
    _expenseModel = expenseModel;
    emitLoadedState();
  }

  void _initFields(ExpenseModel expenseModel) {
    _description.text = expenseModel.description;
    _expenseDate.text = expenseModel.asDate.brazillianDateFormat();
    _amount.text = expenseModel.amount.toString();
  }

  void emitLoadedState() {
    emit(ExpenseLoadedState(
      description: _description,
      expenseDate: _expenseDate,
      amount: _amount,
    ));
  }

  Future<void> updateExpense(
    Function(ExpenseModel expense) editExpenseCallback,
  ) async {
    emit(ExpenseLoadingState());

    var editedExpense = _expenseModel!.copyWith(
      description: _description.text,
      expenseDate: parsedExpenseDate(),
      amount: double.parse(_amount.text),
    );

    var params = UpdateExpenseParams(
      LoginModel(identity: 'ccObDnaf', password: ''),
      editedExpense,
    );

    var response = await _updateExpenseUseCase(params);

    response.processResult(
      onSuccess: (expense) => editExpenseCallback(expense),
      onFailure: (_) async {
        editExpenseCallback(editedExpense.copyWith(isEditPending: true));
      },
    );
  }

  Future<void> createExpense(
    Function(ExpenseModel expense) createExpenseCallback,
  ) async {
    emit(ExpenseLoadingState());

    final expense = ExpenseModel.create(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      description: _description.text,
      expenseDate: parsedExpenseDate(),
      amount: double.parse(_amount.text),
      isSubmitted: false,
    );

    var params = CreateExpenseParams(
      LoginModel(identity: 'ccObDnaf', password: ''),
      expense,
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

  String parsedExpenseDate() {
    var toParse = '';
    var splitted = _expenseDate.text.split('/');

    toParse += splitted.last;
    toParse += splitted.elementAt(1);
    toParse += splitted.first;

    return DateTime.parse(toParse).toString();
  }

}
