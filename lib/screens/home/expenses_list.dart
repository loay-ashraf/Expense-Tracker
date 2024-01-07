import 'package:flutter/material.dart';
import 'expense_item.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required List<Expense> expenses,
    required void Function({required Expense expense}) onRemoveExpense,
  })  : _expenses = expenses,
        _onRemoveExpense = onRemoveExpense;

  final List<Expense> _expenses;
  final void Function({required Expense expense}) _onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(_expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          _onRemoveExpense(expense: _expenses[index]);
        },
        child: ExpenseItem(
          _expenses[index],
        ),
      ),
    );
  }
}
