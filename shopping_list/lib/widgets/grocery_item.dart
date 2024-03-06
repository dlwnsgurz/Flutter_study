import 'package:flutter/material.dart';

class GroceryListItem extends StatelessWidget {
  const GroceryListItem(
      {super.key,
      required this.title,
      required this.color,
      required this.quantity});

  final String title;
  final Color color;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      iconColor: color,
      leading: Container(
        width: 20,
        height: 20,
        color: color,
      ),
      trailing: Text(
        quantity.toString(),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
