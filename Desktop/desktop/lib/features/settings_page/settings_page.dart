import 'package:desktop/utils/util.dart';

class StaffModel {
  int? id;
  String? username;
  String? email;
  String? role;
  String? password;
  String? phone;
  int? restaurantId;
  int? restaurantStaffUserId;
  String? restaurantName;
  String? restaurantDescription;
  String? restaurantAddress;
  String? restaurantPhone;

  StaffModel({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.phone,
    required this.restaurantId,
    required this.restaurantStaffUserId,
    required this.restaurantName,
    required this.restaurantDescription,
    required this.restaurantAddress,
    required this.restaurantPhone,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        role: json["role"],
        phone: json["phone"],
        restaurantId: json["restaurant_id"],
        restaurantStaffUserId: json["restaurant_staff_user_id"],
        restaurantName: json["restaurant_name"],
        restaurantDescription: json["restaurant_description"],
        restaurantAddress: json["restaurant_address"],
        restaurantPhone: json["restaurant_phone"],
      );

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': Me.password,
      'phone': phone,
      'restaurant_name': restaurantName,
      'restaurant_description': restaurantDescription,
      'restaurant_address': restaurantAddress,
      'restaurant_phone': restaurantPhone,
    };
  }
}
