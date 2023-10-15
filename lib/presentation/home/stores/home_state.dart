import 'package:onfly_app/domain/home/model/expense_model.dart';

abstract class HomeState {}

class HomeInitialState implements HomeState {}

class HomeLoadingState implements HomeState {}

class HomeLoadedState implements HomeState {
  final List<ExpenseModel> expenses;

  HomeLoadedState(this.expenses);
}

class HomeErrorState implements HomeState {}
