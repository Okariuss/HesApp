import 'package:desktop/features/user/user_model.dart';
import 'package:flutter/material.dart';

class TableModel {
  final int id;
  final int restaurantId;
  final String name;
  final List<UserModel>? users;
  late final Color? color;

  TableModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.users,
  }) {
    updateColor();
  }

  void updateColor() {
    if (users == null || users!.isEmpty) {
      color = Colors.grey;
    } else {
      final hasOrders =
          users!.any((user) => user.orders != null && user.orders!.isNotEmpty);
      if (hasOrders) {
        color = Colors.red;
      }
    }
  }

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'],
      restaurantId: json['restaurant_id'],
      name: json['name'],
      users: json["users"] == null
          ? []
          : List<UserModel>.from(
              json["users"]!.map((x) => UserModel.fromJson(x))),
    );
  }
}
