import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/features/menu_page/models/menu_page_items_model.dart';
import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final MenuItemsModel item;
  final VoidCallback onItemTap;

  const MenuItemWidget({
    super.key,
    required this.item,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onItemTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _itemDetails(),
              ),
              Constants.kbigSizedBoxSize,
              // SizedBox(
              //   width: 80,
              //   height: 80,
              //   child: item.image != null
              //       ? Image.file(
              //           item.image ?? "",
              //           fit: BoxFit.cover,
              //         )
              //       : const Icon(Icons.restaurant_menu),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Column _itemDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name ?? "",
          style: const TextStyle(
            fontSize: Constants.contentSize,
            fontWeight: Constants.bold,
          ),
        ),
        Constants.ktooSmallSizedBoxSize,
        Text(item.description ?? ""),
        Constants.ktooSmallSizedBoxSize,
        Text(
          '${item.price?.toStringAsFixed(2)} TL',
          style: const TextStyle(
            fontSize: Constants.contentSize,
            fontWeight: Constants.bold,
          ),
        ),
      ],
    );
  }
}
