import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/home/home_screen.dart';
import 'package:expense_tracker/screens/add_new_expense/add_new_expense_screen.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/database/database_facade.dart';
import 'package:expense_tracker/database/app_database_table.dart';

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
  List<Expense> _expenses = [];
  DatabaseFacade<AppDatatbaseTable>? _manager;

  @override
  void initState() {
    super.initState();
    _initalizeState();
  }

  Future<void> _initalizeState() async {
    await _initializeDatabaseManager();
    await _createExpensesTable();
    await _getExpenses();
  }

  Future _initializeDatabaseManager() async {
    _manager = await DatabaseFacade.initialize<AppDatatbaseTable>(
        databaseFile: 'expenses.db');
  }

  Future _createExpensesTable() async {
    await _manager?.createTable(table: AppDatatbaseTable.expenses, fields: [
      {'name': 'id', 'type': 'TEXT', 'isPrimary': true},
      {'name': 'title', 'type': 'TEXT', 'isPrimary': false},
      {'name': 'amount', 'type': 'DOUBLE', 'isPrimary': false},
      {'name': 'date', 'type': 'TEXT', 'isPrimary': false},
      {'name': 'category', 'type': 'TEXT', 'isPrimary': false}
    ]);
  }

  Future _getExpenses() async {
    var expenses = await _manager?.getItems(table: AppDatatbaseTable.expenses);
    if (expenses != null) {
      setState(() {
        _expenses = expenses.map((e) => Expense.fromMap(map: e)).toList();
      });
    }
  }

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
      _manager?.addItem(table: AppDatatbaseTable.expenses, item: expense.map);
    });
  }

  void _removeExpense({required Expense expense}) {
    setState(() {
      _expenses.remove(expense);
      _manager?.deleteItems(
          table: AppDatatbaseTable.expenses,
          predicate: 'id = \'${expense.id}\'');
    });
  }

  void _readdExpense({required Expense expense, required int expenseIndex}) {
    setState(() {
      _expenses.insert(expenseIndex, expense);
      _manager?.addItem(table: AppDatatbaseTable.expenses, item: expense.map);
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
