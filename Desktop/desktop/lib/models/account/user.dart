import 'dart:convert';

class RegisterPersonnelModel {
  RegisterPersonnelModel({
    this.username,
    this.email,
    this.password,
    this.role,
    this.restaurantName,
    this.restaurantLocation,
    this.restaurantContact,
  });

  factory RegisterPersonnelModel.fromJson(Map<String, dynamic> json) =>
      RegisterPersonnelModel(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        restaurantName: json["restaurant_name"],
        restaurantLocation: json["restaurant_location"],
        restaurantContact: json["restaurant_contact"],
      );

  factory RegisterPersonnelModel.fromRawJson(String str) =>
      RegisterPersonnelModel.fromJson(json.decode(str));

  String? username;
  String? email;
  String? password;
  String? role = "restaurant";
  String? restaurantName;
  String? restaurantLocation;
  String? restaurantContact;
}
