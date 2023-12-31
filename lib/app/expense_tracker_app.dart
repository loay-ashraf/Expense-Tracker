import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/home/home_screen.dart';

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() {
    return _ExpenseTrackerAppState();
  }
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(
            child: HomeScreen(),
          ),
        ],
      ),
    );
  }
}
