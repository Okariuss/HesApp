import 'package:flutter/material.dart';

class RemoveTableDialog extends StatelessWidget {
  final String tableName;
  final Function() onRemove;

  const RemoveTableDialog({
    required this.tableName,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remove Table'),
      content: Text('Are you sure you want to remove the table "$tableName"?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            onRemove();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('Remove'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
