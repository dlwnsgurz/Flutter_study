import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectScreen,
  });

  final void Function(String) onSelectScreen;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fastfood,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Cooking Up!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.restaurant,
              size: 32,
            ),
            title: Text(
              "Meals",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              onSelectScreen("Meals");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 32,
            ),
            title: Text(
              "Filters",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              onSelectScreen("Filters");
            },
          ),
        ],
      ),
    );
  }
}
