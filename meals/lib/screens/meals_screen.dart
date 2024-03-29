import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details_screen.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  void _selectMeal(Meal meal, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = ListView.builder(
      itemCount: meals.length,
      itemBuilder: ((context, index) {
        return MealItem(meal: meals[index], onSelect: _selectMeal);
      }),
    );

    if (meals.isEmpty) {
      mainContent = const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "No Meals",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Try Choose Other Category!",
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
    if (title == null) return mainContent;
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: mainContent,
    );
  }
}
