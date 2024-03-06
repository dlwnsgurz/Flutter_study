import 'package:flutter/material.dart';
import 'package:shopping_list/screens/new_item.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/grocery_item.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    print(_groceryItems.length);
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItemScreen(),
        fullscreenDialog: true,
      ),
    );
    if (newItem == null) {
      return;
    } else {
      setState(() {
        _groceryItems.add(newItem);
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
