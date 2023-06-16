import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/features/menu_page/models/menu_page_categories_model.dart';
import 'package:desktop/features/menu_page/models/menu_page_items_model.dart';
import 'package:desktop/features/menu_page/widgets/menu_item_widget.dart';
import 'package:desktop/models/menu_item.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<MenuCategoriesModel> menuCategories;
  final Function(MenuCategoriesModel, MenuItemsModel, int) onItemTap;

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
              padding: Constants.defaultPadding,
              child: Text(
                category.name ?? "",
                style: const TextStyle(
                  fontSize: Constants.headerSize,
                  fontWeight: Constants.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: category.items?.length,
              itemBuilder: (context, itemIndex) {
                final item = category.items?[itemIndex];
                return MenuItemWidget(
                  item: item!,
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
