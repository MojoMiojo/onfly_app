import 'package:flutter/foundation.dart';
import 'package:onfly_app/data/utils/exceptions/unknown_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDatasource {
  final expenseIds = 'expensesId';

  late SharedPreferences prefs;

  Future<void> writeExpense(dynamic id, dynamic data) async {
    List<String> items = await _getExpensesId();

    await prefs.setString(id, data);
    if (!items.contains(id)) {
      items.add(id);
    }

    _debugPrint('SharedPreferences [writeExpense] | ${data.toString()}');
  }

  Future<void> removeExpense(dynamic id) async {
    List<String> items = await _getExpensesId();
    var wasRemoved = await prefs.remove('counter');
    if (!wasRemoved) return;

    items.removeWhere((element) => element == id);
  }

  Future<dynamic> readExpense(dynamic id) async {
    List<String> items = await _getExpensesId();

    if (!items.contains(id)) throw UnkownException();
    final String? action = prefs.getString('action');

    return action;
  }

  Future<List<String>> _getExpensesId() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? items = prefs.getStringList(expenseIds);

    if (items == null) {
      var expenseIdsExists = await prefs.setStringList(expenseIds, <String>[]);
      if (expenseIdsExists) throw UnkownException();
    }

    return items = prefs.getStringList(expenseIds)!;
  }

  void _debugPrint(dynamic data) {
    if (kDebugMode) {
      print(data);
    }
  }
}
