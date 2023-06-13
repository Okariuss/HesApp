import 'package:desktop/models/menu_category.dart';
import 'package:desktop/models/menu_item.dart';
import 'package:desktop/widgets/menu_widgets/menu_item_widget.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<MenuCategory> menuCategories;
  final Function(MenuCategory, MenuItem, int) onItemTap;

  const CategoryList({
    super.key,
    required this.menuCategories,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: menuCategories.length,
      itemBuilder: (context, index) {
        final category = menuCategories[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                category.title,
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: category.items.length,
              itemBuilder: (context, itemIndex) {
                final item = category.items[itemIndex];
                return MenuItemWidget(
                  item: item,
                  onItemTap: () => onItemTap(category, item, itemIndex),
                );
              },
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1.0,
          height: 1.0,
        );
      },
    );
  }
}
