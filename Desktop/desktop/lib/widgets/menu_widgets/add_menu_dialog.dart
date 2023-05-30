import 'package:desktop/viewModel/menu_view_model.dart';
import 'package:desktop/widgets/menu_widgets/add_category_dialog.dart';
import 'package:desktop/widgets/menu_widgets/add_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMenuDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Add'),
      children: [
        ListTile(
          leading: const Icon(Icons.restaurant_menu),
          title: const Text('Add Item'),
          onTap: () => _showAddItemDialog(context),
        ),
        ListTile(
          leading: const Icon(Icons.category),
          title: const Text('Add Category'),
          onTap: () => _showAddCategoryDialog(context),
        ),
      ],
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final selectedCategory = Provider.of<MenuViewModel>(
      context,
      listen: false,
    ).menuCategories;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddItemDialog(
          title: 'Add Item',
          categories: selectedCategory,
        );
      },
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddCategoryDialog(
          title: 'Add Category',
        );
      },
    );
  }
}
