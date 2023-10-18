import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:onfly_app/domain/home/model/expense_model.dart';
import 'package:onfly_app/presentation/expense/stores/expense_cubit.dart';
import 'package:onfly_app/presentation/expense/stores/expense_state.dart';
import 'package:onfly_app/presentation/presentation.dart';
import 'package:onfly_app/presentation/utils/extensions/text_input_masks.dart';

class ExpensePage extends StatefulWidget {
  final ExpenseModel? expenseModel;
  final Function(ExpenseModel expense)? editCallback;
  final Function(ExpenseModel expense)? addCallback;

  const ExpensePage({
    Key? key,
    this.expenseModel,
    this.editCallback,
    this.addCallback,
  }) : super(key: key);

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  late ExpenseCubit _cubit;

  @override
  void initState() {
    _cubit = GetIt.I();
    _cubit.fetch(expenseModel: widget.expenseModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocBuilder<ExpenseCubit, ExpenseState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is ExpenseLoadingState) {
            return Container(
              color: OnflyColors.cultured,
              child: const Center(
                child: OnflyCircularLoading(),
              ),
            );
          }
          if (state is ExpenseLoadedState) {
            return Scaffold(
              appBar: OnflyAppBar(
                title: widget.expenseModel == null
                    ? 'Adicionar despesa'
                    : 'Editar despesa',
              ),
              body: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  OnflyTextField(
                    fieldName: 'Descrição',
                    hintText: 'Almoço',
                    controller: state.description,
                  ),
                  const SizedBox(height: 8),
                  OnflyTextField(
                    fieldName: 'Data da despesa',
                    hintText: '15/10/2023',
                    masks: [TextInputMasks.brazillianDateMask],
                    controller: state.expenseDate,
                  ),
                  const SizedBox(height: 8),
                  OnflyTextField(
                    fieldName: 'Valor',
                    hintText: '34,15',
                    masks: [TextInputMasks.amountFields],
                    controller: state.amount,
                  ),
                  const SizedBox(height: 24),
                  OnflyFilledButton(
                    onPressed: () {
                      widget.editCallback != null
                          ?
                        _cubit.updateExpense(
                              (expense) {
                                Navigator.pop(context);
                                return widget.editCallback!(expense);
                              },
                            )
                          : _cubit.createExpense(
                              (expense) {
                                Navigator.pop(context);
                                return widget.addCallback!(expense);
                              },
                            );
                    },
                    padding: 16,
                    child: Text(
                      widget.expenseModel == null ? 'Adicionar' : 'Salvar',
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.photo_camera_rounded),
              ),
            );
          }
          return GenericErrorState(onTryAgain: () => _cubit.emitLoadedState());
        },
      ),
    );
  }
}
