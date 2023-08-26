import 'package:flutter/material.dart';
import 'package:meals/models/meal_model.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.onToggleFavourite,
  });

  final Meal meal;
  final void Function(Meal meal) onToggleFavourite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              onToggleFavourite(meal);
            },
            icon: const Icon(Icons.star),
            splashColor: Theme.of(context).colorScheme.onPrimaryContainer,
            disabledColor: Colors.white,
            enableFeedback: true,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 15.0),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: meal.ingredients.map((ingredient) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ingredient,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 15.0),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: meal.steps.map((step) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    step,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
