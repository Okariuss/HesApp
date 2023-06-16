import 'package:auto_route/auto_route.dart';
import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/menu_page/models/menu_page_categories_model.dart';
import 'package:desktop/features/menu_page/models/menu_page_items_model.dart';
import 'package:desktop/features/menu_page/viewModels/menu_view_model.dart';
import 'package:desktop/features/menu_page/widgets/add_menu_dialog.dart';
import 'package:desktop/features/menu_page/widgets/edit_category_dialog.dart';
import 'package:desktop/features/menu_page/widgets/edit_item_dialog.dart';
import 'package:desktop/features/menu_page/widgets/menu_item_widget.dart';
import 'package:desktop/utils/util.dart';
import 'package:desktop/widgets/custom_delete_icon.dart';
import 'package:desktop/widgets/custom_edit_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch menu categories when the screen initializes
    Provider.of<MenuPageViewModel>(context, listen: false)
        .fetchMenuCategories(Me.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    final menuViewModel = Provider.of<MenuPageViewModel>(context);
    final menuCategories = menuViewModel.menuCategories;

    if (menuCategories.isEmpty) {
      return _noDataInMenu(context);
    }

    return _buildMenu(menuCategories, context);
  }

  Scaffold _buildMenu(
      List<MenuCategoriesModel> menuCategories, BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: menuCategories.length,
        itemBuilder: (context, categoryIndex) {
          final category = menuCategories[categoryIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _categoryHeader(category, context),
              _allItems(category, menuCategories),
            ],
          );
        },
      ),
      floatingActionButton: customFloatingActionButton(context),
    );
  }

  GridView _allItems(
      MenuCategoriesModel category, List<MenuCategoriesModel> menuCategories) {
    if (category.items!.isEmpty) {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 1,
        childAspectRatio: 15,
        children: [
          Center(
              child: Text(
            "${LanguageItems.noItemForCategory}${category.name}",
            style: const TextStyle(color: Constants.buttonTextColor),
          )),
        ],
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: category.items!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // There are 2 items in row
        childAspectRatio:
            7, // Each grid item will have a width that is 7 times its height.
      ),
      itemBuilder: (context, itemIndex) {
        final item = category.items![itemIndex];
        return MenuItemWidget(
          item: item,
          onItemTap: () => _showEditItemDialog(
            context,
            category,
            menuCategories,
            item,
          ),
        );
      },
    );
  }

  Padding _categoryHeader(MenuCategoriesModel category, BuildContext context) {
    return Padding(
      padding: Constants.smallPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category.name ?? '',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Constants.buttonTextColor),
          ),
          _editAndDeleteOperations(context, category),
        ],
      ),
    );
  }

  Row _editAndDeleteOperations(
      BuildContext context, MenuCategoriesModel category) {
    return Row(
      children: [
        IconButton(
          onPressed: () => _showEditCategoryDialog(context, category),
          icon: customEditIcon(),
        ),
        IconButton(
          onPressed: () => _deleteCategory(category),
          icon: customDeleteIcon(),
        ),
      ],
    );
  }

  FloatingActionButton customFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Constants.addIcon,
      onPressed: () => _showAddMenuDialog(context),
    );
  }

  Scaffold _noDataInMenu(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(LanguageItems.noData),
      ),
      floatingActionButton: customFloatingActionButton(context),
    );
  }

  void _showAddMenuDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddMenuDialog();
      },
    );
  }

  void _showEditItemDialog(BuildContext context, MenuCategoriesModel category,
      List<MenuCategoriesModel> categories, MenuItemsModel item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditItemDialog(
          title: LanguageItems.editItem,
          item: item,
          categories: categories,
          category: category,
        );
      },
    );
  }

  void _showEditCategoryDialog(
      BuildContext context, MenuCategoriesModel category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditCategoryDialog(
          title: LanguageItems.editCategory,
          category: category,
        );
      },
    );
  }

  void _deleteCategory(MenuCategoriesModel category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(LanguageItems.confirmDelete),
          content: Text('${LanguageItems.sureRemove} ${category.name}?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text(
                    LanguageItems.cancel,
                    style: TextStyle(color: Constants.buttonTextColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    LanguageItems.remove,
                    style: TextStyle(color: Constants.errorColor),
                  ),
                  onPressed: () {
                    _performCategoryDelete(category);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _performCategoryDelete(MenuCategoriesModel category) {
    final menuViewModel =
        Provider.of<MenuPageViewModel>(context, listen: false);
    menuViewModel.deleteMenuCategory(category.id);
  }
}
