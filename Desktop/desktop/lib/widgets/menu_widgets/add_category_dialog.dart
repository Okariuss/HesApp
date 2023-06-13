import 'package:desktop/models/menu_category.dart';
import 'package:desktop/viewModel/menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoryDialog extends StatefulWidget {
  final String title;

  const AddCategoryDialog({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _AddCategoryDialogState createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _categoryController = TextEditingController();
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _categoryController,
        decoration: const InputDecoration(labelText: 'Category'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final category = _categoryController.text;
            if (category.isNotEmpty) {
              final newCategory = MenuCategory(title: category, items: []);
              Provider.of<MenuViewModel>(context, listen: false)
                  .addCategory(newCategory);
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
