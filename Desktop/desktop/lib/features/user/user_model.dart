import 'dart:convert';

import 'package:desktop/features/order_page/orders_page_model.dart';

class UserModel {
  int? id;
  String? username;
  String? email;
  String? role;
  String? phone;
  List<OrderModel>? orders;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.role,
    this.phone,
    this.orders,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        role: json["role"],
        phone: json["phone"],
        orders: json["orders"] == null
            ? []
            : List<OrderModel>.from(
                json["orders"]!.map((x) => OrderModel.fromJson(x))),
      );
}
