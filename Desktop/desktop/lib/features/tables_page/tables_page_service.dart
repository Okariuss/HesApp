import 'dart:convert';
import 'dart:io';

import 'package:desktop/utils/util.dart';
import 'package:http/http.dart' as http;

import 'package:desktop/features/tables_page/tables_page.dart';

class TableService {
  static const String baseUrl = 'https://hesapp.link';

  static Future<List<TableModel>> fetchTables(int restaurantId) async {
    final url = '$baseUrl/tables/$restaurantId';
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ${Me.token}'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> tableData = jsonDecode(response.body);
      final tables =
          tableData.map((json) => TableModel.fromJson(json)).toList();
      return tables;
    } else {
      throw Exception('Failed to fetch tables');
    }
  }

  static Future<TableModel> createTable(String? name) async {
    try {
      var url = Uri.parse('$baseUrl/table');
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${Me.token}',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
        }),
      );
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return TableModel.fromJson(responseData);
      } else {
        throw Exception(
            'Failed to create table. Error: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  static Future<TableModel> updateTable(
    int? tableId,
    String? name,
  ) async {
    try {
      final url = Uri.parse('${baseUrl}/table/$tableId');
      final response = await http.put(
        url,
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${Me.token}',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return TableModel.fromJson(responseData);
      } else {
        throw Exception(
            'Failed to update table. Error: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  static Future<void> deleteTable(int? tableId) async {
    try {
      var url = Uri.parse("${baseUrl}/table/$tableId");
      final http.Response response = await http.delete(
        url,
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${Me.token}',
        },
      );
      if (response.statusCode == 204) {
        // Deletion successful
        return;
      } else {
        throw Exception(
            'Failed to delete table. Error: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }
}
