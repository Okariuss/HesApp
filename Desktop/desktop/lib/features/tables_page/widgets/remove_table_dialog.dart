import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/tables_page/tables_page.dart';
import 'package:desktop/features/tables_page/tables_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RemoveTableDialog extends StatefulWidget {
  final TableModel tableName;

  const RemoveTableDialog({
    Key? key,
    required this.tableName,
  }) : super(key: key);

  @override
  State<RemoveTableDialog> createState() => _RemoveTableDialogState();
}

class _RemoveTableDialogState extends State<RemoveTableDialog> {
  @override
  Widget build(BuildContext context) {
    return _confirmDeleteTable(context);
  }

  AlertDialog _confirmDeleteTable(BuildContext context) {
    return AlertDialog(
      title: const Text(LanguageItems.removeTable),
      content: Text('${LanguageItems.sureRemove} ${widget.tableName.name}?'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                LanguageItems.cancel,
                style: TextStyle(color: Constants.buttonTextColor),
              ),
            ),
            TextButton(
              onPressed: () {
                final tableViewModel =
                    Provider.of<TablesScreenViewModel>(context, listen: false);
                tableViewModel.deleteTable(widget.tableName.id);
                Navigator.of(context).pop();
              },
              child: const Text(
                LanguageItems.remove,
                style: TextStyle(color: Constants.errorColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
