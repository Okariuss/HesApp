import 'package:desktop/models/menu_category.dart';
import 'package:desktop/models/menu_item.dart';
import 'package:flutter/material.dart';

class MenuViewModel with ChangeNotifier {
  List<MenuCategory> _menuCategories = [
    MenuCategory(
      title: 'Salads',
      items: [
        MenuItem(
          name: 'Greek Salad',
          description:
              'Fresh mixed greens, tomatoes, cucumbers, olives, feta cheese.',
          price: 7.99,
        ),
        MenuItem(
          name: 'Caesar Salad',
          description:
              'Crisp romaine lettuce, croutons, Parmesan cheese, Caesar dressing.',
          price: 6.99,
        ),
      ],
    ),
    MenuCategory(
      title: 'Burgers',
      items: [
        MenuItem(
          name: 'Classic Burger',
          description: 'Beef patty, lettuce, tomato, onion, pickles.',
          price: 9.99,
        ),
        MenuItem(
          name: 'Cheeseburger',
          description: 'Beef patty, cheese, lettuce, tomato, onion, pickles.',
          price: 10.99,
        ),
      ],
    ),
  ];

  List<MenuCategory> get menuCategories => _menuCategories;

  void addCategory(MenuCategory category) {
    _menuCategories.add(category);
    notifyListeners();
  }

  void addItem(MenuCategory category, MenuItem item) {
    final categoryIndex = _menuCategories.indexOf(category);
    if (categoryIndex != -1) {
      _menuCategories[categoryIndex].items.add(item);
      notifyListeners();
    }
  }

  void editItem(MenuCategory category, MenuItem item, MenuItem updatedItem) {
    final categoryIndex = _menuCategories.indexOf(category);
    if (categoryIndex != -1) {
      final itemIndex = _menuCategories[categoryIndex].items.indexOf(item);
      if (itemIndex != -1) {
        _menuCategories[categoryIndex].items[itemIndex] = updatedItem;
        notifyListeners();
      }
    }
  }

  void removeCategory(MenuCategory category) {
    _menuCategories.remove(category);
    notifyListeners();
  }

  void removeItem(MenuCategory category, MenuItem item) {
    final categoryIndex = _menuCategories.indexOf(category);
    if (categoryIndex != -1) {
      _menuCategories[categoryIndex].items.remove(item);
      notifyListeners();
    }
  }
}
