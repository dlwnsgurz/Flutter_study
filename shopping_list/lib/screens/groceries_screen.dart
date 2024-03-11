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
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https("shopping-flutter-d8993-default-rtdb.firebaseio.com",
        "shopping-list.json");
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _error = "에러가 발생했어요. 다시 시도해주세요!";
        });
      }
      if (response.body == "null") {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
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
        _isLoading = false;
        _groceryItems = loadedItems;
      });
    } catch (error) {
      setState(() {
        _error = "Something went Wrong! Please Try agian Later!";
      });
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItemScreen(),
        fullscreenDialog: true,
      ),
    );

    if (newItem == null) return;

    setState(
      () {
        _groceryItems.add(newItem);
      },
    );
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    final url = Uri.https("shopping-flutter-d8993-default-rtdb.firebaseio.com",
        "shopping-list/${item.id}.json");
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = ListView.builder(
      itemCount: _groceryItems.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(_groceryItems[index].id),
        onDismissed: (direction) {
          _removeItem(_groceryItems[index]);
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
    if (_isLoading) {
      mainContent = const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      mainContent = Center(
        child: Text(
          _error!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
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
