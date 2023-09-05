import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal_model.dart';
import 'package:meals/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouriteMealsProvider);
    final isFavourite = favouriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favouriteMealsProvider.notifier)
                  .toggleMealFavouriteStatus(meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  content: Text(
                    wasAdded
                        ? 'Meal added as a favourite'
                        : 'Meal removed as a favourite',
                  ),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavourite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavourite),
              ),
            ),
            splashColor: Theme.of(context).colorScheme.onPrimaryContainer,
            disabledColor: Colors.white,
            enableFeedback: true,
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          ScaffoldMessenger.of(context).clearSnackBars();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                transitionOnUserGestures: true,
                tag: meal.id,
                child: Image.network(
                  meal.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
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
      ),
    );
  }
}
