import 'dart:async';
import 'dart:io';

import 'package:hesapp_mobile/model/get_profile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileApi {
  static Future<GetProfile> getProfile(
    String token,
  ) async {
    try {
      var url = Uri.parse(
          'https://hesapp.herokuapp.com/get_profile');
      final http.Response response = await http.get(
        url,
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      ).timeout(const Duration(seconds: 360));
      return GetProfile.fromJson(jsonDecode(response.body));
    } on TimeoutException {
      return GetProfile();
    } on Exception {
      return GetProfile();
    }
  }
}