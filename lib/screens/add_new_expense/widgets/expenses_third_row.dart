import 'package:flutter/material.dart';
import 'package:expense_tracker/models/category.dart';

class ExpensesThirdRow extends StatelessWidget {
  const ExpensesThirdRow(
      {super.key,
      required bool isPortrait,
      required Category selectedCategory,
      required void Function(Category?) onSelectCategory,
      required void Function() onSubmit,
      required void Function() onExit})
      : _isPortrait = isPortrait,
        _selectedCategory = selectedCategory,
        _onSelectCategory = onSelectCategory,
        _onSubmit = onSubmit,
        _onExit = onExit;

  final bool _isPortrait;
  final Category _selectedCategory;
  final void Function(Category?) _onSelectCategory;
  final void Function() _onSubmit;
  final void Function() _onExit;

  @override
  Widget build(BuildContext context) {
    if (_isPortrait) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownButton(
            value: _selectedCategory,
            items: Category.values
                .map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(
                      category.name.toUpperCase(),
                    ),
                  ),
                )
                .toList(),
            onChanged: _onSelectCategory,
          ),
          const Spacer(),
          TextButton(
            onPressed: _onExit,
            child: const Text('Cancel'),
          ),
          const SizedBox(
            width: 20.0,
          ),
          ElevatedButton(
            onPressed: _onSubmit,
            child: const Text('Save Expense'),
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          TextButton(
            onPressed: _onExit,
            child: const Text('Cancel'),
          ),
          const SizedBox(
            width: 20.0,
          ),
          ElevatedButton(
            onPressed: _onSubmit,
            child: const Text('Save Expense'),
          ),
        ],
      );
    }
  }
}
