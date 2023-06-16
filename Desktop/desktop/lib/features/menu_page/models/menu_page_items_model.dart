import 'dart:convert';

class MenuItemsModel {
  int? id;
  int? categoryId;
  String? name;
  String? description;
  double? price;
  String? image;

  MenuItemsModel({
    this.id,
    this.categoryId,
    this.name,
    this.description,
    this.price,
    this.image,
  });

  factory MenuItemsModel.fromRawJson(String str) =>
      MenuItemsModel.fromJson(json.decode(str));

  factory MenuItemsModel.fromJson(Map<String, dynamic> json) => MenuItemsModel(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        image: json["image"],
      );
}
