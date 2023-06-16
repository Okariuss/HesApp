import 'package:desktop/features/menu_page/models/menu_page_categories_model.dart';
import 'package:desktop/features/menu_page/models/menu_page_items_model.dart';
import 'package:desktop/features/menu_page/services/menu_page_categories_service.dart';
import 'package:desktop/features/menu_page/services/menu_page_items_service.dart';
import 'package:flutter/material.dart';

class MenuPageViewModel extends ChangeNotifier {
  List<MenuCategoriesModel> menuCategories = [];

  Future<void> fetchMenuCategories(int? id) async {
    try {
      menuCategories = await MenuCategoriesService.fetchMenuCategories(id);
      sortMenuCategories();
      notifyListeners();
    } catch (e) {
      throw Exception('Error fetching menu categories: $e');
      // Handle the error gracefully, e.g., show an error message to the user
    }
  }

  void sortMenuCategories() {
    menuCategories.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
  }

  Future<void> createMenuCategory(String? name) async {
    try {
      final newCategory = await MenuCategoriesService.createMenuCategory(name);
      menuCategories.add(newCategory);
      sortMenuCategories();
      notifyListeners();
    } catch (e) {
      throw Exception('Error creating menu category: $e');
      // Handle the error gracefully, e.g., show an error message to the user
    }
  }

  Future<void> updateMenuCategory(int? categoryId, String? name) async {
    try {
      final updatedCategory =
          await MenuCategoriesService.updateMenuCategory(categoryId, name);
      final index =
          menuCategories.indexWhere((category) => category.id == categoryId);
      if (index != -1) {
        menuCategories[index] = updatedCategory;
        sortMenuCategories();
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error updating menu category: $e');
      // Handle the error gracefully, e.g., show an error message to the user
    }
  }

  Future<void> deleteMenuCategory(int? categoryId) async {
    try {
      await MenuCategoriesService.deleteMenuCategory(categoryId);
      menuCategories.removeWhere((category) => category.id == categoryId);
      notifyListeners();
    } catch (e) {
      throw Exception('Error deleting menu category: $e');
      // Handle the error gracefully, e.g., show an error message to the user
    }
  }

  Future<List<MenuItemsModel>> fetchMenuItems(int? categoryId) async {
    try {
      final items = await MenuItemsService.fetchMenuItems(categoryId);
      return items;
    } catch (e) {
      print('Error fetching menu items: $e');
      // Handle the error gracefully, e.g., show an error message to the user
      return [];
    }
  }

  Future<void> createMenuItem({
    int? categoryId,
    MenuItemsModel? menuItemsModel,
  }) async {
    try {
      final newItem = await MenuItemsService.addMenuItem(
        categoryId: categoryId,
        menuItemsModel: menuItemsModel,
      );

      final categoryIndex =
          menuCategories.indexWhere((category) => category.id == categoryId);
      if (categoryIndex != -1) {
        menuCategories[categoryIndex]
            .items
            ?.add(MenuItemsModel.fromJson(newItem));
        sortMenuItems(categoryIndex);
        notifyListeners();
      } else {
        throw Exception("Invalid categoryId");
      }
    } catch (e) {
      throw Exception('Error creating menu item: $e');
    }
  }

  void sortMenuItems(int categoryIndex) {
    menuCategories[categoryIndex]
        .items
        ?.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
  }

  Future<void> editMenuItem({
    int? categoryId,
    MenuItemsModel? menuItemsModel,
  }) async {
    try {
      final updatedItem = await MenuItemsService.editMenuItem(
        categoryId: categoryId,
        menuItemsModel: menuItemsModel,
      );

      final categoryIndex =
          menuCategories.indexWhere((category) => category.id == categoryId);
      if (categoryIndex != -1) {
        final category = menuCategories[categoryIndex];
        final items = category.items;
        if (items != null) {
          final itemIndex =
              items.indexWhere((item) => item.id == menuItemsModel?.id);
          if (itemIndex != -1) {
            category.items![itemIndex] = MenuItemsModel.fromJson(updatedItem);
            sortMenuItems(categoryIndex);
            notifyListeners();
            return;
          }
        }
        throw Exception("Item not found");
      }

      throw Exception("Category not found");
    } catch (e) {
      throw Exception('Error editing menu item: $e');
      // Handle the error gracefully, e.g., show an error message to the user
    }
  }

  Future<void> deleteMenuItem(int? itemId) async {
    try {
      await MenuItemsService.deleteMenuItem(itemId);

      final category = menuCategories.firstWhere((category) =>
          category.items?.any((item) => item.id == itemId) ?? false);

      if (category != null) {
        category.items!.removeWhere((item) => item.id == itemId);
        notifyListeners();
      } else {
        throw Exception("Item not found");
      }
    } catch (e) {
      throw Exception('Error deleting menu item: $e');
      // Handle the error gracefully, e.g., show an error message to the user
    }
  }
}
