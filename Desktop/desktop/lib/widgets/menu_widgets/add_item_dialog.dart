import 'dart:io';

import 'package:desktop/models/menu_category.dart';
import 'package:desktop/models/menu_item.dart';
import 'package:desktop/viewModel/menu_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddItemDialog extends StatefulWidget {
  final String title;
  final MenuItem? item;
  final List<MenuCategory> categories;
  final MenuCategory? category;
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
  MenuCategory? selectedCategory;
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
                : widget.item?.imagePath != null
                    ? Image.file(
                        File(widget.item!.imagePath!.path.toString()),
                        width: 200,
                        height: 200,
                      )
                    : const SizedBox(),
            ElevatedButton(
              onPressed: () {
                _pickFile();
              },
              child: const Text('Change Image'),
            ),
            _buildTextField(_nameController, 'Name'),
            _buildTextField(_descriptionController, 'Description'),
            _buildTextField(_priceController, 'Price',
                keyboardType: TextInputType.number),
          ],
        ),
      ),
      actions: [
        _buildCancelButton(),
        _buildSaveButton(),
      ],
    );
  }

  Widget menuCategoriesDropdown() {
    return DropdownButton<MenuCategory>(
      value: selectedCategory,
      items: widget.categories.map((MenuCategory category) {
        return DropdownMenuItem<MenuCategory>(
          value: category,
          child: Text(category.title),
        );
      }).toList(),
      onChanged: (MenuCategory? newValue) {
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
      child: const Text('Cancel'),
    );
  }

  Widget _buildSaveButton() {
    return TextButton(
      onPressed: () {
        final name = _nameController.text;
        final description = _descriptionController.text;
        final price = double.tryParse(_priceController.text) ?? 0.0;

        if (name.isNotEmpty && description.isNotEmpty && price > 0.0) {
          final newItem = MenuItem(
            name: name,
            description: description,
            price: price,
            imagePath: selectedImage,
          );

          if (widget.item != null && widget.category != null) {
            // Editing an existing item
            Provider.of<MenuViewModel>(context, listen: false)
                .removeItem(widget.category!, widget.item!);
            Provider.of<MenuViewModel>(context, listen: false)
                .addItem(selectedCategory!, newItem);
          } else {
            // Adding a new item
            Provider.of<MenuViewModel>(context, listen: false)
                .addItem(selectedCategory!, newItem);
          }

          Navigator.pop(context);
        }
      },
      child: const Text('Save'),
    );
  }
}
