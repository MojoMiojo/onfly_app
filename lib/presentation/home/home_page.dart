import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:onfly_app/domain/home/model/expense_model.dart';
import 'package:onfly_app/presentation/expense/expense_page.dart';
import 'package:onfly_app/presentation/home/stores/home_cubit.dart';
import 'package:onfly_app/presentation/home/stores/home_state.dart';
import 'package:onfly_app/presentation/utils/extensions/extensions.dart';
import 'package:onfly_app/presentation/utils/onfly_colors.dart';
import 'package:onfly_app/presentation/widgets/widgets.dart';

part 'components/home_expense_card.dart';
part 'components/home_floating_action_button.dart';
part 'components/home_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit _cubit;
  
  @override
  void initState() {
    _cubit = GetIt.I();
    _cubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return Container(
            color: OnflyColors.cultured,
            child: const Center(
              child: OnflyCircularLoading(),
            ),
          );
        }
        if (state is HomeErrorState) {
          return GenericErrorState(
            onTryAgain: () => _cubit.fetch(),
          );
        }
        if (state is HomeLoadedState) {
          return Scaffold(
            appBar: const OnflyAppBar(),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              children: [
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: OnflyColors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 0.4,
                        spreadRadius: 0.8,
                        offset: Offset(0, 1),
                        color: Colors.black12,
                      )
                    ],
                  ),
                  child: const Text('Despesas', textAlign: TextAlign.center),
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => _HomeExpenseCard(
                    expense: state.expenses.elementAt(index),
                    onSync: (expense) => _cubit.syncExpense(expense),
                    onDelete: (expense) => _cubit.deleteExpense(expense),
                    onEdit: (ExpenseModel expense) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExpensePage(
                            expenseModel: expense,
                            editCallback: _cubit.updateExpenseCallback,
                          ),
                        ),
                      );
                    },
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: state.expenses.length,
                ),
              ],
            ),
            floatingActionButton: _HomeFloatingActionButton(
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExpensePage(
                    addCallback: _cubit.createExpenseCallback,
                  ),
                ),
              ),
            ),
          );
        }
        return const GenericErrorState();
      },
    );
  }
}
