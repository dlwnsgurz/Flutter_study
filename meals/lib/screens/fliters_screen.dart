import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filter_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.gluetenFree, isChecked);
            },
            value: activeFilters[Filter.gluetenFree]!,
            title: Text(
              "Gluten Free",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            subtitle: Text(
              "Only Include Gluten-Free Meals",
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 14,
              ),
            ),
          ),
          SwitchListTile(
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            value: activeFilters[Filter.lactoseFree]!,
            title: Text(
              "Lactose Free",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            subtitle: Text(
              "Only Include Lactose-Free Meals",
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 14,
              ),
            ),
          ),
          SwitchListTile(
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            value: activeFilters[Filter.vegetarian]!,
            title: Text(
              "Vegetarian",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            subtitle: Text(
              "Only Include Vegetarian Meals",
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 14,
              ),
            ),
          ),
          SwitchListTile(
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            value: activeFilters[Filter.vegan]!,
            title: Text(
              "Vegan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            subtitle: Text(
              "Only Include Vegen Meals",
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
