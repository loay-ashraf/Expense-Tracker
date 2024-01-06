import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/home/home_screen.dart';
import 'package:expense_tracker/screens/add_new_expense/add_new_expense_screen.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() {
    return _ExpenseTrackerAppState();
  }
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
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

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => AddNewExpenseScreen(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense({required Expense expense}) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _removeExpense({required Expense expense}) {
    setState(() {
      _expenses.remove(expense);
    });
  }

  void _readdExpense({required Expense expense, required int expenseIndex}) {
    setState(() {
      _expenses.insert(expenseIndex, expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter ExpenseTracker'),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: HomeScreen(
          expenses: _expenses,
          onRemoveExpense: _removeExpense,
          onReaddExpense: _readdExpense,
        ));
  }
}
