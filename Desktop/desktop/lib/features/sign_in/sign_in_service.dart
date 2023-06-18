import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:desktop/core/constants/error_messages_service.dart';
import 'package:http/http.dart' as http;

import '../../utils/util.dart';

class SignInService {
  static Future<String> authenticate(
    String? email,
    String? password,
  ) async {
    try {
      var url = Uri.parse("https://hesapp.link/auth/login");

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

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Me.setToken(responseData["access_token"]);
        Me.setMail(email!);
        return "login successful";
      } else {
        print('Response data: $responseData');
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('statusCode') &&
            responseData.containsKey('message')) {
          final statusCode = responseData['statusCode'] as int?;
          final message = responseData['message'] as String?;
          throw ErrorMessage(statusCode, message);
        } else {
          throw Exception('${responseData['msg']}');
        }
      }
    } catch (error) {
      throw Exception('$error');
    }
  }
}
