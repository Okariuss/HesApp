import 'package:desktop/features/tables_page/tables_page.dart';
import 'package:desktop/features/tables_page/tables_page_service.dart';
import 'package:flutter/material.dart';

class TablesScreenViewModel extends ChangeNotifier {
  List<TableModel> tables = [];
  TableModel? selectedTable;

  void setSelectedTable(TableModel table) {
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
}
