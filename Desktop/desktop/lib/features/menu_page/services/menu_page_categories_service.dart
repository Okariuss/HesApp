import 'dart:convert';
import 'dart:io';

import 'package:desktop/features/menu_page/models/menu_page_categories_model.dart';
import 'package:http/http.dart' as http;

import 'package:desktop/utils/util.dart';

class MenuCategoriesService {
  static Future<List<MenuCategoriesModel>> fetchMenuCategories(
    int? id,
  ) async {
    try {
      final url = Uri.parse('https://hesapp.link/menu/categories/$id');
      final response = await http.get(
        url,
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${Me.token}'
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final categories = data
            .map((categoryData) => MenuCategoriesModel.fromJson(categoryData))
            .toList();
        return categories;
      } else {
        throw Exception(
            'Failed to fetch menu categories. Error: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  static Future<MenuCategoriesModel> createMenuCategory(String? name) async {
    try {
      var url = Uri.parse('https://hesapp.link/menu/category');
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${Me.token}',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
        }),
      );
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return MenuCategoriesModel.fromJson(responseData);
      } else {
        throw Exception(
            'Failed to create menu category. Error: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  static Future<MenuCategoriesModel> updateMenuCategory(
    int? categoryId,
    String? name,
  ) async {
    try {
      final url = Uri.parse('https://hesapp.link/menu/category/$categoryId');
      final response = await http.put(
        url,
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${Me.token}',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return MenuCategoriesModel.fromJson(responseData);
      } else {
        throw Exception(
            'Failed to update menu category. Error: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  static Future<void> deleteMenuCategory(int? categoryId) async {
    try {
      var url = Uri.parse("https://hesapp.link/menu/category/$categoryId");
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
            'Failed to delete menu category. Error: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }
}
