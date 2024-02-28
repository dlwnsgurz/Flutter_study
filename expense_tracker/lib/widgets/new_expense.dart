import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();

  final void Function(Expense expense) onAddExpense;
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _submitExpenseDate() {
    final enteredAmount = double.tryParse(_amountController.text);
    final isInvalidAmount = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        isInvalidAmount ||
        _selectedDate == null) {
      // show error message
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: const Text("Alert"),
            content: const Text(
                "please make sure a valid title, amount, date and category was entered.."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        amount: enteredAmount,
        title: _titleController.text.trim(),
        category: _selectedCategory,
        date: _selectedDate!,
      ),
    );

    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            keyboardType: TextInputType.name,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    label: Text("Amount"),
                    prefixText: "\$ ",
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _selectedDate == null
                        ? const Text("No Selected Date",
                            textAlign: TextAlign.end)
                        : Text(formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (category) {
                  if (category == null) return;
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                onPressed: _submitExpenseDate,
                child: const Text("Save Expense"),
              )
            ],
          )
        ],
      ),
    );
  }
}