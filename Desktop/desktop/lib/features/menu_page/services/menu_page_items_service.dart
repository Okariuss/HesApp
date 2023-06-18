import 'dart:convert';
import 'dart:io';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/menu_page/models/menu_page_items_model.dart';
import 'package:desktop/utils/util.dart';
import 'package:http/http.dart' as http;

class MenuItemsService {
  static Future<List<MenuItemsModel>> fetchMenuItems(int? categoryId) async {
    try {
      final url = Uri.parse('${LanguageItems.baseUrl}/menu/items/$categoryId');
      final response = await http.get(
        url,
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${Me.token}'
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final menuItems =
            data.map((itemData) => MenuItemsModel.fromJson(itemData)).toList();
        return menuItems;
      } else {
        throw Exception(
            'Failed to fetch menu items. Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  static Future<Map<String, dynamic>> addMenuItem({
    int? categoryId,
    MenuItemsModel? menuItemsModel,
  }) async {
    try {
      var url = Uri.parse("${LanguageItems.baseUrl}/menu/item");
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${Me.token}',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "category_id": categoryId,
          "name": menuItemsModel?.name,
          "description": menuItemsModel?.description,
          "price": menuItemsModel?.price,
          "image": "string",
        }),
      );
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        return responseData;
      } else {
        throw Exception(
            'Failed to add menu item. Error: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  static Future<Map<String, dynamic>> editMenuItem({
    int? categoryId,
    MenuItemsModel? menuItemsModel,
  }) async {
    try {
      var url =
          Uri.parse("${LanguageItems.baseUrl}/menu/item/${menuItemsModel?.id}");
      final http.Response response = await http.put(
        url,
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${Me.token}',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "category_id": categoryId,
          "name": menuItemsModel?.name,
          "description": menuItemsModel?.description,
          "price": menuItemsModel?.price,
          "image": "string",
        }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        return responseData;
      } else {
        throw Exception(
            'Failed to edit menu item. Error: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  static Future<void> deleteMenuItem(int? itemId) async {
    try {
      var url = Uri.parse("${LanguageItems.baseUrl}/menu/item/$itemId");
      final http.Response response = await http.delete(
        url,
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${Me.token}',
        },
      );
      if (response.statusCode == 204) {
        // Deletion successful
        return;
      } else {
        throw Exception(
            'Failed to delete menu item. Error: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }
}
