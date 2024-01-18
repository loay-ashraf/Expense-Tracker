import 'package:flutter/material.dart';

class ExpensesFirstRow extends StatelessWidget {
  const ExpensesFirstRow(
      {super.key,
      required bool isPortrait,
      required TextEditingController titleController,
      required TextEditingController amountController})
      : _isPortrait = isPortrait,
        _titleController = titleController,
        _amountController = amountController;

  final bool _isPortrait;
  final TextEditingController _titleController;
  final TextEditingController _amountController;

  @override
  Widget build(BuildContext context) {
    if (_isPortrait) {
      return TextField(
        controller: _titleController,
        maxLength: 50,
        decoration: const InputDecoration(
          label: Text('Title'),
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
          ),
          const SizedBox(width: 20),
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
        ],
      );
    }
  }
}
