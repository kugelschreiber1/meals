import 'package:flutter/material.dart';
import 'package:meals/models/category_model.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MealsScreen(
            title: category.title,
            meals: filteredMeals,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
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
        ),
        builder: (BuildContext context, Widget? child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: const Offset(0, 0),
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          );
        });
  }
}
