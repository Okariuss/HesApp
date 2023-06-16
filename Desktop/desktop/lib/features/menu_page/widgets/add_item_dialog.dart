import 'dart:io';

import 'package:desktop/core/constants/constants.dart';
import 'package:desktop/core/constants/language_items.dart';
import 'package:desktop/features/menu_page/models/menu_page_categories_model.dart';
import 'package:desktop/features/menu_page/models/menu_page_items_model.dart';
import 'package:desktop/features/menu_page/viewModels/menu_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddItemDialog extends StatefulWidget {
  final String title;
  final MenuItemsModel? item;
  final List<MenuCategoriesModel> categories;
  final MenuCategoriesModel? category;
  File? selectedImage;

  AddItemDialog(
      {super.key,
      required this.title,
      this.item,
      required this.categories,
      this.category,
      this.selectedImage});

  @override
  // ignore: library_private_types_in_public_api
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  MenuCategoriesModel? selectedCategory;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.item?.description ?? '');
    _priceController =
        TextEditingController(text: widget.item?.price.toString() ?? '');
    selectedCategory = widget.category ?? widget.categories.first;
    selectedImage = widget.selectedImage;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    PlatformFile file = result.files.single;
    setState(() {
      selectedImage = File(file.path!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            menuCategoriesDropdown(),
            selectedImage != null
                ? Image.file(
                    selectedImage!,
                    width: 200,
                    height: 200,
                  )
                : widget.item?.image != null
                    ? Image.file(
                        File(widget.item!.image!.toString()),
                        width: 200,
                        height: 200,
                      )
                    : const SizedBox(),
            Constants.ksmallSizedBoxSize,
            ElevatedButton(
              onPressed: () {
                _pickFile();
              },
              child: const Text(LanguageItems.changeImage),
            ),
            Constants.ksmallSizedBoxSize,
            _buildTextField(_nameController, LanguageItems.itemName),
            Constants.ksmallSizedBoxSize,
            _buildTextField(
                _descriptionController, LanguageItems.itemDescription),
            Constants.ksmallSizedBoxSize,
            _buildTextField(_priceController, LanguageItems.itemPrice,
                keyboardType: TextInputType.number),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCancelButton(),
            _buildSaveButton(),
          ],
        ),
      ],
    );
  }

  Widget menuCategoriesDropdown() {
    return DropdownButton<MenuCategoriesModel>(
      value: selectedCategory,
      items: widget.categories.map((MenuCategoriesModel category) {
        return DropdownMenuItem<MenuCategoriesModel>(
          value: category,
          child: Text(category.name ?? ""),
        );
      }).toList(),
      onChanged: (MenuCategoriesModel? newValue) {
        setState(() {
          selectedCategory = newValue;
        });
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      keyboardType: keyboardType,
    );
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text(
        LanguageItems.cancel,
        style: TextStyle(color: Constants.errorColor),
      ),
    );
  }

  Widget _buildSaveButton() {
    return TextButton(
      onPressed: () {
        final name = _nameController.text;
        final description = _descriptionController.text;
        final price = double.tryParse(_priceController.text) ?? 0.0;

        if (name.isNotEmpty && description.isNotEmpty && price > 0.0) {
          final newItem = MenuItemsModel(
            name: name,
            description: description,
            price: price,
            image: "string",
          );
          Provider.of<MenuPageViewModel>(context, listen: false).createMenuItem(
              categoryId: selectedCategory?.id, menuItemsModel: newItem);

          Navigator.pop(context);
        }
      },
      child: const Text(
        LanguageItems.save,
        style: TextStyle(color: Constants.buttonTextColor),
      ),
    );
  }
}
