import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registedExpenses = [
    Expense(
        title: "Flutter Course",
        amount: 19.8,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Cinema",
        amount: 9.9,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("The Chart"),
          Expanded(child: ExpensesList(expenses: _registedExpenses)),
        ],
      ),
    );
  }
}
