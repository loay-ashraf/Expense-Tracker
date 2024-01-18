import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/models/category.dart';

class ExpensesSecondRow extends StatelessWidget {
  const ExpensesSecondRow(
      {super.key,
      required bool isPortrait,
      DateTime? selectedDate,
      required Category selectedCategory,
      required TextEditingController amountController,
      required void Function() onPresentDatePicker,
      required void Function(Category?) onSelectCategory})
      : _isPortrait = isPortrait,
        _selectedDate = selectedDate,
        _selectedCategory = selectedCategory,
        _amountController = amountController,
        _onPresentDatePicker = onPresentDatePicker,
        _onSelectCategory = onSelectCategory;

  final bool _isPortrait;
  final TextEditingController _amountController;
  final DateTime? _selectedDate;
  final Category _selectedCategory;
  final void Function() _onPresentDatePicker;
  final void Function(Category?) _onSelectCategory;

  @override
  Widget build(BuildContext context) {
    if (_isPortrait) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              decoration: const InputDecoration(
                prefixText: '\$ ',
                label: Text('Amount'),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _selectedDate == null
                      ? 'No date selected'
                      : formatter.format(_selectedDate),
                ),
                IconButton(
                  onPressed: _onPresentDatePicker,
                  icon: const Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _selectedDate == null
                      ? 'No date selected'
                      : formatter.format(_selectedDate),
                ),
                IconButton(
                  onPressed: _onPresentDatePicker,
                  icon: const Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
