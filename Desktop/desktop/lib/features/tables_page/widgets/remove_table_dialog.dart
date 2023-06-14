import 'package:desktop/core/constants/language_items.dart';
import 'package:flutter/material.dart';

class RemoveTableDialog extends StatelessWidget {
  final String tableName;
  final Function() onRemove;

  const RemoveTableDialog({
    super.key,
    required this.tableName,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(LanguageItems.removeTable),
      content: Text(LanguageItems.sureRemoveTable + tableName),
      actions: [
        ElevatedButton(
          onPressed: () {
            onRemove();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text(LanguageItems.remove),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(LanguageItems.cancel),
        ),
      ],
    );
  }
}
