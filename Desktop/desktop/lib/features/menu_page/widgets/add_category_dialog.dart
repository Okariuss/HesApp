import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/menu_page/models/menu_page_categories_model.dart';
import 'package:desktop/features/menu_page/viewModels/menu_view_model.dart';
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
        decoration: const InputDecoration(labelText: LanguageItems.category),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                LanguageItems.cancel,
                style: TextStyle(color: Constants.errorColor),
              ),
            ),
            TextButton(
              onPressed: () {
                final category = _categoryController.text;
                if (category.isNotEmpty) {
                  final newCategory =
                      MenuCategoriesModel(name: category, items: []);
                  Provider.of<MenuPageViewModel>(context, listen: false)
                      .createMenuCategory(newCategory.name);
                  Navigator.pop(context);
                }
              },
              child: const Text(
                LanguageItems.save,
                style: TextStyle(color: Constants.buttonTextColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
