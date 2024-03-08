import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/models/grocery_item.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _formKey = GlobalKey<FormState>();

  var _enteredName = "";
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;

  var _isSending = false;
  void _saveItem() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      _isSending = true;
    });
    final url = Uri.https("shopping-flutter-d8993-default-rtdb.firebaseio.com",
        "shopping-list.json");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "name": _enteredName,
          "quantity": _enteredQuantity,
          "category": _selectedCategory.name,
        },
      ),
    );
    if (!context.mounted) return;

    final Map<String, dynamic> responseData = jsonDecode(response.body);

    Navigator.of(context).pop(
      GroceryItem(
          id: responseData["name"],
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCategory),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a New Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                maxLines: 1,
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1) {
                    return "1글자 이상 50글자 이하로 입력해주세요.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Quantity"),
                      ),
                      initialValue: "1",
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) return "1이상의 수를 입력해주세요.";
                        return null;
                      },
                      onSaved: (value) {
                        _enteredQuantity = int.tryParse(value!)!;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField(
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(category.value.name),
                              ],
                            ),
                          )
                      ],
                      value: _selectedCategory,
                      onChanged: (value) {
                        _selectedCategory = value!;
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending
                        ? null
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: const Text("Reset"),
                  ),
                  ElevatedButton(
                    onPressed: _isSending ? null : _saveItem,
                    child: _isSending
                        ? const CircularProgressIndicator()
                        : const Text("Add Item "),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
