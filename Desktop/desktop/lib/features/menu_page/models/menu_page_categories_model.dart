import 'dart:convert';

import 'package:desktop/features/menu_page/models/menu_page_items_model.dart';

class MenuCategoriesModel {
  int? id;
  int? restaurantId;
  String? name;
  List<MenuItemsModel>? items;

  MenuCategoriesModel({
    this.id,
    this.restaurantId,
    this.name,
    this.items,
  });

  factory MenuCategoriesModel.fromRawJson(String str) =>
      MenuCategoriesModel.fromJson(json.decode(str));

  factory MenuCategoriesModel.fromJson(Map<String, dynamic> json) =>
      MenuCategoriesModel(
        id: json["id"],
        restaurantId: json["restaurant_id"],
        name: json["name"],
        items: json["items"] == null
            ? []
            : List<MenuItemsModel>.from(
                json["items"]!.map((x) => MenuItemsModel.fromJson(x))),
      );
}
