import 'package:desktop/models/member.dart';
import 'package:desktop/viewModel/tables_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoveMembersToTableDialog extends StatelessWidget {
  final String title;
  final String sourceTable;
  final List<Member> memberList;
  final void Function(String?) onTableSelected; // Updated parameter type

  const MoveMembersToTableDialog({
    Key? key,
    required this.title,
    required this.sourceTable,
    required this.memberList,
    required this.onTableSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TablesScreenViewModel>(context);
    final availableTables = tableData
        .where((tableData) => tableData.table != sourceTable)
        .map((tableData) => tableData.table)
        .toList();
    String? selectedTable =
        availableTables.isNotEmpty ? availableTables[0] : null;
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Move members from "$sourceTable" to:'),
          const SizedBox(height: 16),
          DropdownButton<String>(
            value: selectedTable,
            onChanged: onTableSelected,
            items: availableTables.map((tableName) {
              return DropdownMenuItem<String>(
                value: tableName,
                child: Text(tableName),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (selectedTable != null) {
              provider.moveMembersToTable(
                  memberList, sourceTable, selectedTable);
            }
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
