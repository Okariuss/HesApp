import 'dart:convert';
import 'dart:io';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/utils/util.dart';
import 'package:http/http.dart' as http;

import 'settings_page.dart';

class SettingsService {
  static Future<StaffModel> getStaffDetails() async {
    var url = Uri.parse("${LanguageItems.baseUrl}/staff");

    try {
      final http.Response response = await http.get(
        url,
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${Me.token}'
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final staff = StaffModel.fromJson(data);
        return staff;
      } else {
        throw Exception('Failed to fetch staff details');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  static Future<String> updateStaffDetails(StaffModel staffData) async {
    var url = Uri.parse("${LanguageItems.baseUrl}/staff");
    final http.Response response = await http.put(
      url,
      body: jsonEncode(staffData),
      headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ${Me.token}',
        HttpHeaders.contentTypeHeader: 'application/json'
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to update staff details');
    }
  }
}
