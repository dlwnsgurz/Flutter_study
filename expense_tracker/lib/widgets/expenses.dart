import 'dart:math';

import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
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

  // 제거
  void _removeExpense(Expense expense) {
    final expenseIndex = _registedExpenses.indexOf(expense);
    setState(() {
      _registedExpenses.remove(expense);
    });
    ScaffoldMessengerState().clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("deleted!"),
        backgroundColor: Colors.black45,
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registedExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  // 추가
  void _addExpense(Expense expense) {
    setState(() {
      _registedExpenses.add(expense);
    });
  }

  void _openExpenseAddOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent =
        const Center(child: Text("No Expenses found, Start Adding some!"));

    if (_registedExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registedExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter ExpenseTrackers",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openExpenseAddOverlay,
          ),
        ],
      ),
      body: width < 600
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chart(expenses: _registedExpenses),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registedExpenses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
