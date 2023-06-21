import 'package:desktop/features/user/user_model.dart';

class TableModel {
  final int id;
  final int restaurantId;
  final String name;
  final List<UserModel>? users;

  TableModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.users,
  });

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
