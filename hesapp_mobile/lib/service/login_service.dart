import 'dart:io';

import 'package:hesapp_mobile/service/server_information.dart';
import 'package:hesapp_mobile/util/util.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class LoginService {
  static Future<String> login(
    String username,
    String password
  ) async {
    var url = Uri.parse('https://hesapp.herokuapp.com/login');
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "username": username,
        "password": password
      })
    ).timeout(const Duration(seconds: 360));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      Me.setToken = responseData["access_token"];
      Me.setName = username;
      return "login successful";
    } else {
      final responseData = jsonDecode(response.body);
      throw Exception(responseData["message"]);
    }
  }
}
