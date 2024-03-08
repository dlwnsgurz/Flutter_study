import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/screens/new_item.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/grocery_item.dart';
import 'package:http/http.dart' as http;

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  List<GroceryItem> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https("shopping-flutter-d8993-default-rtdb.firebaseio.com",
        "shopping-list.json");
    final response = await http.get(url);
    final Map<String, dynamic>? listData = json.decode(response.body);
    if (listData == null) return;

    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries.firstWhere(
        (element) {
          return element.value.name == item.value["category"];
        },
      ).value;

      loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value["name"],
          quantity: item.value["quantity"],
          category: category));
    }
    setState(() {
      _groceryItems = loadedItems;
    });
  }

  void _addItem() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewItemScreen(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = ListView.builder(
      itemCount: _groceryItems.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(_groceryItems[index].id),
        onDismissed: (direction) {
          _groceryItems.removeAt(index);
        },
        background: Container(
          color: Colors.red.shade300,
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "삭제됩니다.",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
        ),
        child: GroceryListItem(
          title: _groceryItems[index].name,
          color: _groceryItems[index].category.color,
          quantity: _groceryItems[index].quantity,
        ),
      ),
    );

    if (_groceryItems.isEmpty) {
      mainContent = const Center(
        child: Text(
          "Add New Item!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Groceries"),
          actions: [
            IconButton(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: mainContent);
  }
}
