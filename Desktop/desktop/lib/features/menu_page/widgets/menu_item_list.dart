import 'package:desktop/features/menu_page/models/menu_page_items_model.dart';
import 'package:desktop/features/menu_page/widgets/menu_item_widget.dart';
import 'package:flutter/material.dart';

class MenuItemList extends StatelessWidget {
  final List<MenuItemsModel> items;
  final Function(MenuItemsModel) onItemTap;

  const MenuItemList({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return MenuItemWidget(
          item: item,
          onItemTap: () => onItemTap(item),
        );
      },
    );
  }
}
