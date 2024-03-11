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
  final List<GroceryItem> _groceryItems = [];
  late Future<List<GroceryItem>> _loadedItems;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https("shopping-flutter-d8993-default-rtdb.firebaseio.com",
        "shopping-list.json");
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      throw Exception("Failed to Fetch Grocery Items. Please Try Again Later!");
    }
    if (response.body == "null") {
      return [];
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
    return loadedItems;
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
      body: FutureBuilder(
        future: _loadedItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Add New Item!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) => Dismissible(
                key: ValueKey(snapshot.data![index].id),
                onDismissed: (direction) {
                  _removeItem(snapshot.data![index]);
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
                  title: snapshot.data![index].name,
                  color: snapshot.data![index].category.color,
                  quantity: snapshot.data![index].quantity,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
