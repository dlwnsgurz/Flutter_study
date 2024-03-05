import 'package:flutter/material.dart';

class GroceryItem extends StatelessWidget {
  const GroceryItem(
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
      leading: ColoredBox(
        color: color,
        child: const SizedBox(
          width: 20,
          height: 20,
        ),
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
