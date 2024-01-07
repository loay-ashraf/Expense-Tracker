import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/home/home_screen.dart';
import 'package:expense_tracker/screens/add_new_expense/add_new_expense_screen.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseTrackerApp extends StatefulWidget {
  ExpenseTrackerApp({super.key});

  final ColorScheme kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 96, 59, 181),
  );

  final ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125),
  );

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

  void _addNewExpense({required BuildContext context}) {
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
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: widget.kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: widget.kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.kDarkColorScheme.primaryContainer,
            foregroundColor: widget.kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: widget.kDarkColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: widget.kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: widget.kColorScheme.onPrimaryContainer,
          foregroundColor: widget.kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: widget.kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: widget.kColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      home: HomeScreen(
        expenses: _expenses,
        onAddNewExpense: _addNewExpense,
        onRemoveExpense: _removeExpense,
        onReaddExpense: _readdExpense,
      ),
    );
  }
}
