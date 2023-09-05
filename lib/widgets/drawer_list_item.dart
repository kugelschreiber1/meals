import 'package:flutter/material.dart';

class DrawerListItem extends StatelessWidget {
  const DrawerListItem({
    super.key,
    required this.icon,
    required this.titleText,
    required this.onTap,
  });

  final IconData icon;
  final String titleText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26.0,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      title: Text(
        titleText,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 24.0,
            ),
      ),
      onTap: onTap,
    );
  }
}
