import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:onfly_app/domain/home/model/expense_model.dart';
import 'package:onfly_app/presentation/expense/stores/expense_cubit.dart';
import 'package:onfly_app/presentation/expense/stores/expense_state.dart';
import 'package:onfly_app/presentation/presentation.dart';
import 'package:onfly_app/presentation/utils/extensions/text_input_masks.dart';
import 'package:onfly_app/presentation/utils/extensions/text_input_validators.dart';

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
                    ? 'Add expense'
                    : 'Edit expense',
              ),
              body: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  OnflyTextField(
                    formKey: _cubit.decriptionFormKey,
                    fieldName: 'Description',
                    hintText: 'Lunch',
                    validate: TextInputValidators.validateDecriptionField,
                    controller: state.description,
                  ),
                  const SizedBox(height: 8),
                  OnflyTextField(
                    formKey: _cubit.expenseDateFormKey,
                    fieldName: 'Expense date',
                    hintText: '15/10/2023',
                    masks: [TextInputMasks.brazillianDateMask],
                    validate: TextInputValidators.validateDateField,
                    inputType: TextInputType.number,
                    controller: state.expenseDate,
                  ),
                  const SizedBox(height: 8),
                  OnflyTextField(
                    formKey: _cubit.amountFormKey,
                    fieldName: 'Value',
                    hintText: '34,15',
                    validate: TextInputValidators.validateAmount,
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    masks: [TextInputMasks.amountFields],
                    controller: state.amount,
                  ),
                  const SizedBox(height: 24),
                  OnflyFilledButton(
                    onPressed: () {
                      var isDecriptionFormKey =
                          _cubit.decriptionFormKey.currentState!.validate();
                      var isExpenseDateFormKey =
                          _cubit.expenseDateFormKey.currentState!.validate();
                      var isAmountFormKey =
                          _cubit.amountFormKey.currentState!.validate();

                      if (isDecriptionFormKey &&
                          isExpenseDateFormKey &&
                          isAmountFormKey) {
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
                      }
                    },
                    padding: 16,
                    child: Text(
                      widget.expenseModel == null ? 'Add' : 'Save',
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
