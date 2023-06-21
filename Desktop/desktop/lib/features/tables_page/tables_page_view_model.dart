import 'dart:async';

import 'package:desktop/features/order_page/orders_page_service.dart';
import 'package:desktop/features/tables_page/tables_page.dart';
import 'package:desktop/features/tables_page/tables_page_service.dart';
import 'package:desktop/utils/util.dart';
import 'package:flutter/material.dart';

class TablesScreenViewModel extends ChangeNotifier {
  List<TableModel> tables = [];
  TableModel? selectedTable;
  int? allOrders;

  void setSelectedTable(TableModel? table) {
    selectedTable = table;
    notifyListeners();
  }

  void sortItems() {
    tables.sort((a, b) => (a.id).compareTo(b.id));
  }

  Future<void> fetchTables(int id) async {
    try {
      tables = await TableService.fetchTables(id);
      sortItems();
      notifyListeners();
    } catch (e) {
      throw Exception('Error fetching menu categories: $e');
    }
  }

  Future<void> createTable(String? name) async {
    try {
      final newTable = await TableService.createTable(name);
      tables.add(newTable);
      sortItems();
      notifyListeners();
    } catch (e) {
      throw Exception('Error creating menu category: $e');
    }
  }

  Future<void> updateTable(int? tableId, String? name) async {
    try {
      final updatedTable = await TableService.updateTable(tableId, name);
      var tableIndex = tables.indexWhere((element) => element.id == tableId);
      tables[tableIndex] = updatedTable;
      if (selectedTable != null && selectedTable!.id == tableId) {
        selectedTable = updatedTable;
      }
      sortItems();
      notifyListeners();
    } catch (e) {
      throw Exception('Error editing table: $e');
    }
  }

  Future<void> deleteTable(int? tableId) async {
    try {
      await TableService.deleteTable(tableId);

      tables.removeWhere((item) => item.id == tableId);
      notifyListeners();
    } catch (e) {
      throw Exception('Error deleting menu item: $e');
    }
  }

  Future<void> updateOrderStatus(int orderId, String newStatus) async {
    try {
      await OrderService.updateOrderStatus(orderId, newStatus);
      await fetchTables(Me.restaurantId);
      getAllOrderCount();
      notifyListeners();
    } on Exception catch (e) {
      // TODO
      throw Exception('Error updating order status: $e');
    }
  }

  void getAllOrderCount() {
    allOrders = tables
        .expand((table) => table.users ?? [])
        .where((user) => user.orders != null && user.orders!.isNotEmpty)
        .map((user) => user.orders!)
        .expand((orders) => orders)
        .length;
    notifyListeners(); // Notify listeners about the updated order count
  }
}
