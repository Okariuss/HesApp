import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:flutter/material.dart';

class RenameTableDialog extends StatefulWidget {
  final String oldName;
  final Function(String) onRename;

  const RenameTableDialog({
    super.key,
    required this.oldName,
    required this.onRename,
  });

  @override
  RenameTableDialogState createState() => RenameTableDialogState();
}

class RenameTableDialogState extends State<RenameTableDialog> {
  final TextEditingController _newNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(LanguageItems.renameTable),
      content: TextField(
        controller: _newNameController,
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
                    final newName = _newNameController.text;
                    if (newName.isNotEmpty) {
                      widget.onRename(newName);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(LanguageItems.rename)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height / 4,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Constants.errorColor)),
                child: const Text(LanguageItems.cancel),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
