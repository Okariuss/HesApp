import 'dart:convert';

class AuthenticateModel {
  AuthenticateModel({
    this.mail,
    this.password,
  });

  factory AuthenticateModel.fromJson(Map<String, dynamic> json) =>
      AuthenticateModel(
        mail: json["email"],
        password: json["password"],
      );

  factory AuthenticateModel.fromRawJson(String str) =>
      AuthenticateModel.fromJson(json.decode(str));

  String? mail;
  String? password;
}
