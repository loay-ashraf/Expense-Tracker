import 'package:flutter/material.dart';
import 'expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Expense> _expenses = [
    Expense(
        title: 'Flutter',
        amount: 20.5,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 23.5,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('The chart'),
        Expanded(child: ExpensesList(expenses: _expenses)),
      ],
    );
  }
}
