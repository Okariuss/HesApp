import 'package:desktop/models/menu_category.dart';
import 'package:desktop/models/menu_item.dart';
import 'package:desktop/viewModel/menu_view_model.dart';
import 'package:desktop/widgets/menu_widgets/add_item_dialog.dart';
import 'package:desktop/widgets/menu_widgets/add_menu_dialog.dart';
import 'package:desktop/widgets/menu_widgets/menu_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MenuViewModel>(
        builder: (context, menuViewModel, _) {
          return ListView.builder(
            itemCount: menuViewModel.menuCategories.length,
            itemBuilder: (context, categoryIndex) {
              final category = menuViewModel.menuCategories[categoryIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      category.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: category.items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 7,
                    ),
                    itemBuilder: (context, itemIndex) {
                      final item = category.items[itemIndex];
                      return MenuItemWidget(
                        item: item,
                        onItemTap: () => showEditItemDialog(
                          context,
                          category,
                          menuViewModel.menuCategories,
                          item,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddMenuDialog(context),
      ),
    );
  }

  void _showAddMenuDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddMenuDialog();
      },
    );
  }

  void showEditItemDialog(BuildContext context, MenuCategory category,
      List<MenuCategory> categories, MenuItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddItemDialog(
          title: 'Edit Item',
          item: item,
          categories: categories,
          category: category,
        );
      },
    );
  }
}
