import 'package:desktop/models/menu_item.dart';
import 'package:desktop/widgets/menu_widgets/menu_item_widget.dart';
import 'package:flutter/material.dart';

class MenuItemList extends StatelessWidget {
  final List<MenuItem> items;
  final Function(MenuItem) onItemTap;

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
