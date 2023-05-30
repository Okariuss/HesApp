import 'dart:io';

import 'package:desktop/models/menu_item.dart';
import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onItemTap;

  const MenuItemWidget({
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(item.description),
                    SizedBox(height: 8),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.0),
              Container(
                width: 80,
                height: 80,
                child: item.imagePath != null
                    ? Image.file(
                        item.imagePath!,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.restaurant_menu),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
