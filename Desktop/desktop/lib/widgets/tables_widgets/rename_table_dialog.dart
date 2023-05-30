import 'package:flutter/material.dart';

class RenameTableDialog extends StatefulWidget {
  final String oldName;
  final Function(String) onRename;

  const RenameTableDialog({
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
      title: const Text('Rename Table'),
      content: TextField(
        controller: _newNameController,
        decoration: InputDecoration(
          labelText: 'New Table Name',
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            final newName = _newNameController.text;
            if (newName.isNotEmpty) {
              widget.onRename(newName);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Rename'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
