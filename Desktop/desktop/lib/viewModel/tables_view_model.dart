import 'package:desktop/models/delivery.dart';
import 'package:desktop/models/member.dart';
import 'package:desktop/models/table.dart';
import 'package:desktop/widgets/tables_widgets/move_members_to_table_dialog.dart';
import 'package:desktop/widgets/tables_widgets/remove_table_dialog.dart';
import 'package:desktop/widgets/tables_widgets/rename_table_dialog.dart';
import 'package:flutter/material.dart';

List<Tables> tableData = [
  Tables(
    table: "Table 1",
    members: [
      Member(name: 'John', table: "Table 1", deliveries: [
        Delivery(type: 'Pizza', price: 10.0, numberOfDelivery: 1),
        Delivery(type: 'Coke', price: 2.0, numberOfDelivery: 3),
      ], acceptedOrders: []),
      Member(name: 'Joseph', table: "Table 1", deliveries: [
        Delivery(type: 'Lahmacun', price: 20.0, numberOfDelivery: 3),
        Delivery(type: 'Coke', price: 2.0, numberOfDelivery: 2),
      ], acceptedOrders: []),
      Member(name: 'Lisa', table: "Table 1", deliveries: [
        Delivery(type: 'Burger', price: 8.0, numberOfDelivery: 1),
        Delivery(type: 'Water', price: 1.0, numberOfDelivery: 2),
      ], acceptedOrders: []),
    ],
  ),
  Tables(
    table: "Table 2",
    members: [
      Member(name: 'Mike', table: "Table 2", deliveries: [
        Delivery(type: 'Steak', price: 18.0, numberOfDelivery: 1),
        Delivery(type: 'Beer', price: 5.0, numberOfDelivery: 1),
      ], acceptedOrders: []),
      Member(
          name: 'Steve', table: "Table 2", deliveries: [], acceptedOrders: []),
    ],
  ),
  Tables(table: "Table 3", members: [])
];

class TablesScreenViewModel extends ChangeNotifier {
  String? selectedTable;

  Color getTableColor(String tableIndex) {
    final memberCount = getMemberCount(tableIndex);
    if (memberCount > 0) {
      final deliveriesExist = tableData
          .where((table) => table.table == tableIndex)
          .expand((table) => table.members ?? [])
          .any((member) => member.deliveries.isNotEmpty);

      if (deliveriesExist) {
        return Colors.red;
      } else {
        return Colors.green;
      }
    } else {
      return Colors.grey;
    }
  }

  int getMemberCount(String tableIndex) {
    return tableData
        .where((table) => table.table == tableIndex)
        .expand((table) => table.members!)
        .length;
  }

  List<Member> getMembersAtTable(String tableIndex) {
    final table = tableData.firstWhere((table) => table.table == tableIndex);
    return table.members!;
  }

  void setSelectedTable(String tableIndex) {
    selectedTable = tableIndex;
    notifyListeners();
  }

  void addTable(String tableName) {
    tableData.add(
      Tables(table: tableName, members: []),
    );
    notifyListeners();
  }

  void renameTable(String oldName, String newName) {
    final table = tableData.firstWhere((table) => table.table == oldName);
    table.table = newName;

    if (selectedTable == oldName) {
      selectedTable = newName;
    }
    notifyListeners();
  }

  void removeTable(String tableName) {
    tableData.removeWhere((table) => table.table == tableName);

    if (selectedTable == tableName) {
      selectedTable = null;
    }
    notifyListeners();
  }

  void moveSelectedMembersToTableDialog(
      BuildContext context, String sourceTable) async {
    final table = tableData.firstWhere((table) => table.table == sourceTable);
    final selectedMembers = table.members!;
    final targetTable = await showDialog<String>(
      context: context,
      builder: (_) => MoveMembersToTableDialog(
        title: 'Move Selected Members',
        sourceTable: sourceTable,
        memberList: selectedMembers,
        onTableSelected: (targetTable) {
          if (targetTable != null) {
            moveMembersToTable(selectedMembers, sourceTable, targetTable);
            notifyListeners();
          }
        },
      ),
    );
  }

  void moveMembersToTableDialog(BuildContext context, String sourceTable,
      Function(String?) onTableSelected) {
    final table = tableData.firstWhere((table) => table.table == sourceTable);
    showDialog(
      context: context,
      builder: (_) => MoveMembersToTableDialog(
        title: 'Move Members',
        sourceTable: sourceTable,
        memberList: table.members!,
        onTableSelected: onTableSelected,
      ),
    );
    notifyListeners();
  }

  void moveMembersToTable(
      List<Member> members, String sourceTable, String targetTable) {
    for (final member in members) {
      member.table = targetTable;
    }
    notifyListeners();
  }

  void renameTableDialog(
      BuildContext context, String oldName, Function(String) onRename) {
    showDialog(
      context: context,
      builder: (_) => RenameTableDialog(
        oldName: oldName,
        onRename: onRename,
      ),
    );
  }

  void removeTableDialog(
      BuildContext context, String tableName, Function() onRemove) {
    showDialog(
      context: context,
      builder: (_) => RemoveTableDialog(
        tableName: tableName,
        onRemove: onRemove,
      ),
    );
  }
}
