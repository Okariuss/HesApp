import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/menu_page/models/menu_page_categories_model.dart';
import 'package:desktop/features/menu_page/viewModels/menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCategoryDialog extends StatefulWidget {
  final String title;
  final MenuCategoriesModel category;

  const EditCategoryDialog({
    Key? key,
    required this.title,
    required this.category,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditCategoryDialogState createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _categoryController = TextEditingController(text: widget.category.name);
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(widget.title)),
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
                final newCategoryName = _categoryController.text;
                if (newCategoryName.isNotEmpty) {
                  Provider.of<MenuPageViewModel>(context, listen: false)
                      .updateMenuCategory(
                    widget.category.id,
                    newCategoryName,
                  );
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
