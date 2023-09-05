import 'package:flutter/material.dart';
import 'package:meals/widgets/drawer_list_item.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 18.0),
                Text(
                  "Cooking Up",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
          DrawerListItem(
            icon: Icons.restaurant,
            titleText: 'Meals',
            onTap: () {
              onSelectScreen('meals');
            },
          ),
          DrawerListItem(
            icon: Icons.settings,
            titleText: 'Filters',
            onTap: () {
              onSelectScreen('filters');
            },
          ),
          DrawerListItem(
            icon: Icons.close,
            titleText: 'Close',
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
