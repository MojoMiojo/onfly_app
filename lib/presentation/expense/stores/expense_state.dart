import 'package:flutter/material.dart';

abstract class ExpenseState {}

class ExpenseInitialState implements ExpenseState {}

class ExpenseLoadingState implements ExpenseState {}

class ExpenseLoadedState implements ExpenseState {
  final TextEditingController description;
  final TextEditingController expenseDate;
  final TextEditingController amount;

  ExpenseLoadedState({
    required this.description,
    required this.expenseDate,
    required this.amount,
  });
}

class ExpenseErrorState implements ExpenseState {}
