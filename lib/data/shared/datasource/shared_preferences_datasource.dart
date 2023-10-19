import 'package:flutter/foundation.dart';
import 'package:onfly_app/data/utils/exceptions/unknown_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDatasource {
  final expenseIds = 'expensesId';

  late SharedPreferences prefs;

  Future<void> writeExpense(dynamic id, dynamic data) async {
    List<String> expenses = await _getExpensesId();

    await prefs.setString(id, data);
    if (!expenses.contains(id)) {
      expenses.add(id);
    }
    _saveExpensesId(expenses);
    _debugPrint('SharedPreferences [writeExpense] | ${data.toString()}');
  }

  Future<void> removeExpense(dynamic id) async {
    List<String> expenses = await _getExpensesId();
    var wasRemoved = await prefs.remove(id);
    if (!wasRemoved) return;

    expenses.removeWhere((element) => element == id);
    _saveExpensesId(expenses);
  }

  Future<List<dynamic>> readAllExpense() async {
    List<String> expensesId = await _getExpensesId();
    List<dynamic> expenses = [];

    for (var id in expensesId) {
      var expense = await readExpense(id);
      expenses.add(expense);
    }

    return expenses;
  }

  Future<dynamic> readExpense(dynamic id) async {
    List<String> expenses = await _getExpensesId();

    if (!expenses.contains(id)) throw UnkownException();
    final String? expense = prefs.getString(id);

    return expense;
  }

  Future<List<String>> _getExpensesId() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? expenses = prefs.getStringList(expenseIds);

    if (expenses == null) {
      var expenseIdsExists = await prefs.setStringList(expenseIds, <String>[]);
      if (expenseIdsExists) throw UnkownException();
    }

    return expenses = prefs.getStringList(expenseIds)!;
  }

  Future<void> _saveExpensesId(List<String> expenses) async {
    var expensesIdSaved = await prefs.setStringList(expenseIds, expenses);
    if (!expensesIdSaved) throw UnkownException();
  }

  void _debugPrint(dynamic data) {
    if (kDebugMode) {
      print(data);
    }
  }
}
