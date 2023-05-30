import 'package:desktop/viewModel/tables_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTableDialog extends StatelessWidget {
  final TextEditingController _tableNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Table'),
      content: TextField(
        controller: _tableNameController,
        decoration: const InputDecoration(
          labelText: 'Table Name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final tableName = _tableNameController.text.trim();
            if (tableName.isNotEmpty) {
              final viewModel =
                  Provider.of<TablesScreenViewModel>(context, listen: false);
              viewModel.addTable(tableName);
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
