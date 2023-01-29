import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../utils/util.dart';

class AccountService {
  static Future<String> registerPersonnel(
    String? username,
    String? password,
    String? email,
    String? restaurantName,
    String? restaurantLocation,
    String? restaurantContact,
  ) async {
    var url = Uri.parse('https://hesapp.herokuapp.com/register');
    final http.Response response = await http
        .post(
          url,
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "username": username,
            "password": password,
            "email": email,
            "role": "restaurant",
            "restaurant_name": restaurantName,
            "restaurant_location": restaurantLocation,
            "restaurant_contact": restaurantContact
          }),
        )
        .timeout(const Duration(seconds: 60));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData["message"];
    } else {
      final responseData = jsonDecode(response.body);
      throw Exception(responseData["message"]);
    }
  }

  static Future<String> authenticate(
    String? username,
    String? password,
  ) async {
    var url = Uri.parse('https://hesapp.herokuapp.com/login');
    final http.Response response = await http
        .post(
          url,
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "username": username,
            "password": password,
          }),
        )
        .timeout(const Duration(seconds: 60));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      Me.setToken = responseData["access_token"];
      Me.setName = username!;
      return "login successful";
    } else {
      final responseData = jsonDecode(response.body);
      throw Exception(responseData["message"]);
    }
  }
}
