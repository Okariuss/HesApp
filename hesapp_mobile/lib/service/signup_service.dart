import 'dart:io';

import 'package:hesapp_mobile/service/server_information.dart';
import 'package:hesapp_mobile/util/util.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class SignUpService {
  static Future<String> register(
    String email,
    String username,
    String password,
  ) async {
    var url = Uri.parse('https://hesapp.herokuapp.com/register');
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "username": username,
        "password": password,
        "email": username,
        "role": "customer"
      })
    ).timeout(const Duration(seconds: 360));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData["message"];
    } else {
      final responseData = jsonDecode(response.body);
      throw Exception(responseData["message"]);
    }
  }
}
