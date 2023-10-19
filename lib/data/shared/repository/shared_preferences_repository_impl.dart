import 'dart:convert';

import 'package:onfly_app/data/home/model/expense_dto.dart';
import 'package:onfly_app/data/shared/datasource/shared_preferences_datasource.dart';
import 'package:onfly_app/data/utils/onfly_base_repository.dart';
import 'package:onfly_app/domain/home/model/expense_model.dart';
import 'package:onfly_app/domain/shared/repository/shared_preferences_repository.dart';
import 'package:onfly_app/domain/utils/result.dart';

class SharedPreferencesRepositoryImpl extends OnflyBaseRepository
    implements SharedPreferencesRepository {
  final SharedPreferencesDatasource _sharedPreferencesDatasource;

  SharedPreferencesRepositoryImpl(this._sharedPreferencesDatasource);

  @override
  Future<Result<List<ExpenseModel>, Exception>> readAllExpenses() async {
    try {
      var response = await _sharedPreferencesDatasource.readAllExpense();
      List<dynamic> expensesMap = response.map(
        (source) {
          return jsonDecode(source);
        },
      ).toList();
      
      return Result.success(
        ExpenseDTO.fromDataList({'items': expensesMap})
            .map((expense) => expense.copyWith(isSubmitted: false))
            .toList(),
      );
    } catch (e, t) {
      return handleFailure(error: e, trace: t);
    }
  }

  @override
  Future<Result<bool, Exception>> removeExpense(String id) async {
    try {
      await _sharedPreferencesDatasource.removeExpense(id);

      return Result.success(true);
    } catch (e, t) {
      return handleFailure(error: e, trace: t);
    }
  }

  @override
  Future<Result<bool, Exception>> writeExpense(
      ExpenseModel expenseModel) async {
    try {
      await _sharedPreferencesDatasource.writeExpense(
        expenseModel.id,
        jsonEncode(expenseModel.fromDomain()),
      );
      return Result.success(true);
    } catch (e, t) {
      return handleFailure(error: e, trace: t);
    }
  }
}
