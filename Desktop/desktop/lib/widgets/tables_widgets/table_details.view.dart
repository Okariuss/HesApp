import 'package:desktop/models/member.dart';
import 'package:desktop/models/table.dart';
import 'package:desktop/viewModel/tables_view_model.dart';
import 'package:desktop/widgets/tables_widgets/member_deliveries_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TablesScreenViewModel>(context);
    final selectedTable = viewModel.selectedTable;
    final tableName = selectedTable ?? '';

    if (selectedTable == null) {
      return const Text('Select a table');
    }

    if (tableData == null) {
      return const Text('Table not found');
    }

    final members = viewModel.getMembersAtTable(tableName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(tableName, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        if (members.isNotEmpty)
          MemberDeliveriesListView(members: members.cast<Member>()),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                viewModel.renameTableDialog(
                  context,
                  tableName,
                  (newName) => viewModel.renameTable(tableName, newName),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text('Rename'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                viewModel.removeTableDialog(
                  context,
                  tableName,
                  () => viewModel.removeTable(tableName),
                );
              },
              icon: const Icon(Icons.delete),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              label: const Text('Delete'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () {
            viewModel.moveSelectedMembersToTableDialog(context, tableName);
          },
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Move Selected Members to Another Table'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            viewModel.moveMembersToTableDialog(
              context,
              tableName,
              (newTableName) {
                if (newTableName != null) {
                  if (newTableName != tableName) {
                    final targetTable = tableData
                        .firstWhere((table) => table.table == newTableName);
                    if (targetTable != null) {
                      targetTable.members?.addAll(members.toList());
                    } else {
                      viewModel.addTable(newTableName);
                      final newTable = tableData.last;
                      newTable.members?.addAll(members.toList());
                    }

                    final sourceTable = tableData
                        .firstWhere((table) => table.table == tableName);
                    if (sourceTable != null) {
                      final newMembers = sourceTable.members!.toList();
                      newMembers
                          .removeWhere((member) => members.contains(member));

                      final newTableData =
                          Tables(table: sourceTable.table, members: newMembers);

                      tableData = tableData
                          .where((table) => table.table != sourceTable.table)
                          .toList()
                        ..add(newTableData);
                    }

                    // Update the selected table if necessary
                    if (viewModel.selectedTable == tableName) {
                      viewModel.setSelectedTable(newTableName);
                    }
                  }
                }
              },
            );
          },
          icon: const Icon(Icons.move_to_inbox),
          label: const Text('Move All Members to Another Table'),
        ),
      ],
    );
  }
}
