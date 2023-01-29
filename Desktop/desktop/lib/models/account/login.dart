import 'dart:convert';

class AuthenticateModel {
  AuthenticateModel({
    this.username,
    this.password,
  });

  factory AuthenticateModel.fromJson(Map<String, dynamic> json) =>
      AuthenticateModel(
        username: json["username"],
        password: json["password"],
      );

  factory AuthenticateModel.fromRawJson(String str) =>
      AuthenticateModel.fromJson(json.decode(str));

  String? username;
  String? password;
}
