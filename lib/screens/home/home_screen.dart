import 'package:flutter/material.dart';
import 'expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required List<Expense> expenses,
    required void Function({required Expense expense}) onRemoveExpense,
  })  : _expenses = expenses,
        _onRemoveExpense = onRemoveExpense;

  final List<Expense> _expenses;
  final void Function({required Expense expense}) _onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('The chart'),
        Expanded(
            child: ExpensesList(
          expenses: _expenses,
          onRemoveExpense: _onRemoveExpense,
        )),
      ],
    );
  }
}
