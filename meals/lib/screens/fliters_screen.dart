import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filter_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFreeFilterSet = false;
  var _veganFreeFilterSet = false;

  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filterProvider);
    _glutenFreeFilterSet = activeFilters[Filter.gluetenFree]!;
    _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
    _vegetarianFreeFilterSet = activeFilters[Filter.vegetarian]!;
    _veganFreeFilterSet = activeFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          ref.read(filterProvider.notifier).setFilters({
            Filter.gluetenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegan: _veganFreeFilterSet,
            Filter.vegetarian: _vegetarianFreeFilterSet,
          });
          Navigator.of(context).pop();
        },
        child: Column(
          children: [
            SwitchListTile(
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
              value: _glutenFreeFilterSet,
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
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
              value: _lactoseFreeFilterSet,
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
                setState(() {
                  _vegetarianFreeFilterSet = isChecked;
                });
              },
              value: _vegetarianFreeFilterSet,
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
                setState(() {
                  _veganFreeFilterSet = isChecked;
                });
              },
              value: _veganFreeFilterSet,
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
      ),
    );
  }
}
