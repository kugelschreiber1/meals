import 'package:flutter/material.dart';
import 'package:meals/models/meal_model.dart';
import 'package:meals/screens/meal_details_screen.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavourite,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavourite;

  void _onSelectMealItem(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MealDetailsScreen(
              meal: meal, onToggleFavourite: onToggleFavourite);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent;
    if (meals.isEmpty) {
      mainContent = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Oops ... nothing here",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              "Try selecting a different category",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    } else {
      mainContent = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return MealItem(
            meal: meals[index],
            onSelectMealItem: () {
              _onSelectMealItem(context, meals[index]);
            },
          );
        },
      );
    }

    if (title == null) {
      return mainContent;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
        centerTitle: true,
      ),
      body: mainContent,
    );
  }
}
