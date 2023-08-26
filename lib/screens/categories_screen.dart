import 'package:flutter/material.dart';
import 'package:meals/models/category_model.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.onToggleFavourite,
  });

  final void Function(Meal meal) onToggleFavourite;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MealsScreen(
            title: category.title,
            meals: filteredMeals,
            onToggleFavourite: onToggleFavourite,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: availableCategories.map((category) {
        return CategoryGridItem(
          category: category,
          onSelectCategory: () {
            _selectCategory(context, category);
          },
        );
      }).toList(),
    );
  }
}
