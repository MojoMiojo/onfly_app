import 'package:onfly_app/data/utils/exceptions/response_exception.dart';
import 'package:onfly_app/data/utils/extensions/map_extension.dart';
import 'package:onfly_app/domain/home/model/expense_model.dart';

extension ExpenseDTO on ExpenseModel {
  static ExpenseModel fromData(dynamic response) {
    if (response is! Map<String, dynamic>) throw ResponseException();
    return ExpenseModel(
      id: response.getValue(key: 'id'),
      description: response.getValue(key: 'description'),
      expenseDate: response.getValue(key: 'expense_date'),
      amount: response.getValue(key: 'amount'),
      latitude: response.getValueOrDefault(key: 'latitude', defaultValue: ''),
      longitude: response.getValueOrDefault(key: 'longitude', defaultValue: ''),
      isSubmitted: true,
    );
  }

  static List<ExpenseModel> fromDataList(dynamic response) {
    if (response is! Map<String, dynamic>) throw ResponseException();
    List<dynamic> expenses = response.getValue(key: 'items');
    return expenses.map((expense) => fromData(expense)).toList();
  }
}
