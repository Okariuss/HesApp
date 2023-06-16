import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/features/menu_page/models/menu_page_categories_model.dart';
import 'package:desktop/features/menu_page/models/menu_page_items_model.dart';
import 'package:desktop/features/menu_page/widgets/menu_item_list.dart';
import 'package:flutter/material.dart';

class MenuCategoryWidget extends StatelessWidget {
  final MenuCategoriesModel category;
  final Function(MenuItemsModel) onItemTap;

  const MenuCategoryWidget({
    Key? key,
    required this.category,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryHeader(),
        MenuItemList(
          items: category.items!,
          onItemTap: onItemTap,
        ),
      ],
    );
  }

  Padding _buildCategoryHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        category.name ?? "",
        style: const TextStyle(
          fontSize: Constants.titleSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
