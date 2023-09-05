import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal_model.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);

  bool toggleMealFavouriteStatus(Meal meal) {
    final isMealFavourite = state.contains(meal);

    if (isMealFavourite) {
      state = state.where((meal) {
        return meal.id != meal.id;
      }).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});
