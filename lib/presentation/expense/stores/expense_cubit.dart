import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onfly_app/domain/expense/use_cases/update_expense_use_case.dart';
import 'package:onfly_app/domain/home/model/expense_model.dart';
import 'package:onfly_app/domain/home/model/login_model.dart';
import 'package:onfly_app/presentation/expense/stores/expense_state.dart';
import 'package:onfly_app/presentation/presentation.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final UpdateExpenseUseCase _updateExpenseUseCase;
  ExpenseModel? _expenseModel;

  ExpenseCubit(
    this._updateExpenseUseCase,
  ) : super(ExpenseInitialState());

  final TextEditingController _description = TextEditingController();
  final TextEditingController _expenseDate = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  void fetch({ExpenseModel? expenseModel}) {
    if (expenseModel != null) initFields(expenseModel);

    _expenseModel = expenseModel;

    emit(ExpenseLoadedState(
      description: _description,
      expenseDate: _expenseDate,
      amount: _amount,
    ));
  }

  void initFields(ExpenseModel expenseModel) {
    _description.text = expenseModel.description;
    _expenseDate.text = expenseModel.asDate.brazillianDateFormat();
    _amount.text = expenseModel.amount.toDouble().formatToMoney(symbol: '');
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
}
