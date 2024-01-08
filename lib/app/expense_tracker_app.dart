import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'package:expense_tracker/screens/home/home_screen.dart';
import 'package:expense_tracker/screens/add_new_expense/add_new_expense_screen.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/database/database_facade.dart';
import 'package:expense_tracker/database/app_database_table.dart';

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

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
      enableDrag: false,
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
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: HomeScreen(
        expenses: _expenses,
        onAddNewExpense: _addNewExpense,
        onRemoveExpense: _removeExpense,
        onReaddExpense: _readdExpense,
      ),
    );
  }
}
