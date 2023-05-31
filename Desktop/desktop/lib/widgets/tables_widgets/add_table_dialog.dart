import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/viewModel/tables_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTableDialog extends StatelessWidget {
  final TextEditingController _tableNameController = TextEditingController();

  AddTableDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(LanguageItems.addTable),
      content: TextField(
        controller: _tableNameController,
        decoration: const InputDecoration(
          labelText: LanguageItems.tableName,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 16,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Constants.errorColor)),
                child: const Text(LanguageItems.cancel),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 16,
              child: ElevatedButton(
                onPressed: () {
                  final tableName = _tableNameController.text.trim();
                  if (tableName.isNotEmpty) {
                    final viewModel = Provider.of<TablesScreenViewModel>(
                        context,
                        listen: false);
                    viewModel.addTable(tableName);
                    Navigator.pop(context);
                  }
                },
                child: const Text(LanguageItems.add),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
