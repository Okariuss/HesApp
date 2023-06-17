import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/menu_page/viewModels/menu_view_model.dart';
import 'package:desktop/features/menu_page/widgets/add_category_dialog.dart';
import 'package:desktop/features/menu_page/widgets/add_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMenuDialog extends StatelessWidget {
  const AddMenuDialog({super.key});

  @override
  Widget build(BuildContext context) {
    if (Provider.of<MenuPageViewModel>(context, listen: false)
        .menuCategories
        .isEmpty) {
      return SimpleDialog(
        title: const Text(LanguageItems.add),
        children: [
          ListTile(
            leading: Constants.categoryIcon,
            title: const Text(LanguageItems.addCategory),
            onTap: () => _showAddCategoryDialog(context),
          ),
        ],
      );
    }
    return SimpleDialog(
      title: const Text(LanguageItems.add),
      children: [
        ListTile(
          leading: Constants.restaurantMenu,
          title: const Text(LanguageItems.addItem),
          onTap: () => _showAddItemDialog(context),
        ),
        ListTile(
          leading: Constants.categoryIcon,
          title: const Text(LanguageItems.addCategory),
          onTap: () => _showAddCategoryDialog(context),
        ),
      ],
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final selectedCategory = Provider.of<MenuPageViewModel>(
      context,
      listen: false,
    ).menuCategories;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddItemDialog(
          title: LanguageItems.addItem,
          categories: selectedCategory,
        );
      },
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddCategoryDialog(
          title: LanguageItems.addCategory,
        );
      },
    );
  }
}
