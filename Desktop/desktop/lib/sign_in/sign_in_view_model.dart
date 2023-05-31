import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../utils/util.dart';

class SignInViewModel {
  static Future<String> authenticate(
    String? email,
    String? password,
  ) async {
    var url = Uri.parse("http://13.51.72.244/auth/login");
    final http.Response response = await http
        .post(
          url,
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "email": email,
            "password": password,
          }),
        )
        .timeout(const Duration(seconds: 60));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      Me.setToken = responseData["access_token"];
      Me.setMail = email!;
      return "login successful";
    } else {
      final responseData = jsonDecode(response.body);
      throw Exception(responseData["message"]);
    }
  }
}