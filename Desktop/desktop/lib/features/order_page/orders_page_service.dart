import 'dart:convert';
import 'dart:io';

import 'package:desktop/utils/util.dart';
import 'package:http/http.dart' as http;

class OrderService {
  static Future<void> updateOrderStatus(int orderId, String status) async {
    final url = 'https://hesapp.link/order/$orderId/update-status';

    final body = {
      'status': status,
    };

    final response = await http.put(Uri.parse(url),
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${Me.token}',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      // Status update successful
      print('Order status updated successfully');
    } else {
      // Handle the error
      print('Failed to update order status. Error: ${response.body}');
    }
  }
}
