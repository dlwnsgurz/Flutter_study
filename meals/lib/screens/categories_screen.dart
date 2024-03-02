import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite});

  final void Function(Meal meal) onToggleFavorite;

  void _selectCategory(BuildContext context, Category category) {
    final meals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MealsScreen(
        title: category.title,
        meals: meals,
        onToggleFavorite: onToggleFavorite,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.5,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelect: () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
  }
}
