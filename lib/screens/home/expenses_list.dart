import 'package:flutter/material.dart';
import 'expense_item.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required List<Expense> expenses,
  }) : _expenses = expenses;

  final List<Expense> _expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _expenses.length,
      itemBuilder: (ctx, index) => ExpenseItem(_expenses[index]),
    );
  }
}
