import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_item.dart';
import 'package:shopping_list/widgets/grocery_item.dart';

class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => GroceryItem(
          title: groceryItems[index].name,
          color: groceryItems[index].category.color,
          quantity: groceryItems[index].quantity,
        ),
      ),
    );
  }
}
