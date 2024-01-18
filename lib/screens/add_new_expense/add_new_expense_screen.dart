import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/expenses_first_row.dart';
import 'widgets/expenses_second_row.dart';
import 'widgets/expenses_third_row.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/models/category.dart';

class AddNewExpenseScreen extends StatefulWidget {
  const AddNewExpenseScreen({super.key, required this.onAddExpense});

  final void Function({required Expense expense}) onAddExpense;

  @override
  State<AddNewExpenseScreen> createState() {
    return _AddNewExpenseScreenState();
  }
}

class _AddNewExpenseScreenState extends State<AddNewExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _onPresentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _onSelectCategory(Category? category) {
    if (category == null) {
      return;
    }
    setState(() {
      _selectedCategory = category;
    });
  }

  Future _submit() async {
    bool isInputValid = _validateInput();
    if (isInputValid) {
      _addNewExpense();
      _exit();
    } else {
      await _showValidationDialog();
    }
  }

  bool _validateInput() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    return (!(_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null));
  }

  void _addNewExpense() {
    final enteredAmount = double.tryParse(_amountController.text);

    widget.onAddExpense(
      expense: Expense.withID(
        title: _titleController.text,
        amount: enteredAmount!,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
  }

  Future _showValidationDialog() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text(
            'Please make sure a valid title, amount, date and category was entered.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  void _exit() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final double width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                ExpensesFirstRow(
                  isPortrait: width < 600,
                  titleController: _titleController,
                  amountController: _amountController,
                ),
                const SizedBox(height: 20),
                ExpensesSecondRow(
                  isPortrait: width < 600,
                  selectedDate: _selectedDate,
                  selectedCategory: _selectedCategory,
                  amountController: _amountController,
                  onPresentDatePicker: _onPresentDatePicker,
                  onSelectCategory: _onSelectCategory,
                ),
                const SizedBox(height: 20),
                ExpensesThirdRow(
                    isPortrait: width < 600,
                    selectedCategory: _selectedCategory,
                    onSelectCategory: _onSelectCategory,
                    onSubmit: _submit,
                    onExit: _exit),
              ],
            ),
          ),
        ),
      );
    });
  }
}
