import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/tables_page/tables_page.dart';
import 'package:desktop/features/tables_page/tables_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RenameTableDialog extends StatefulWidget {
  final TableModel table;

  const RenameTableDialog({
    Key? key,
    required this.table,
  }) : super(key: key);

  @override
  RenameTableDialogState createState() => RenameTableDialogState();
}

class RenameTableDialogState extends State<RenameTableDialog> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.table.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(LanguageItems.renameTable),
      content: TextField(
        controller: _nameController,
        decoration: const InputDecoration(
          labelText: LanguageItems.newTableName,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.height / 4,
              child: ElevatedButton(
                onPressed: () {
                  final newName = _nameController.text;
                  if (newName.isNotEmpty) {
                    Navigator.of(context).pop(newName);
                  }
                },
                child: const Text(LanguageItems.rename),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height / 4,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Constants.errorColor),
                ),
                child: const Text(LanguageItems.cancel),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
