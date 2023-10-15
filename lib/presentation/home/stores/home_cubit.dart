import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/domain/home/model/expense_model.dart';
import 'package:onfly_app/presentation/home/stores/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  void fetch() async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(HomeLoadedState(mockedExpenses));
  }

  final mockedExpenses = [
    ExpenseModel(
      title: 'Almoço',
      date: DateTime.now(),
      value: 45.13,
      isSubmitted: false,
    ),
    ExpenseModel(
      title: 'Almoço',
      date: DateTime.now(),
      value: 45.13,
      isSubmitted: false,
    ),
    ExpenseModel(
      title: 'Almoço',
      date: DateTime.now(),
      value: 45.13,
      isSubmitted: false,
    )
  ];
}
