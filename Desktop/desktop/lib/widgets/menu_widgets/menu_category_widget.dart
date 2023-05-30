import 'package:desktop/models/menu_category.dart';
import 'package:desktop/models/menu_item.dart';
import 'package:desktop/widgets/menu_widgets/menu_item_list.dart';
import 'package:flutter/material.dart';

class MenuCategoryWidget extends StatelessWidget {
  final MenuCategory category;
  final Function(MenuItem) onItemTap;

  const MenuCategoryWidget({
    required this.category,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        MenuItemList(
          items: category.items,
          onItemTap: onItemTap,
        ),
      ],
    );
  }
}
