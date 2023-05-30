import 'dart:io';

class MenuItem {
  String name;
  String description;
  double price;
  File? imagePath;

  MenuItem(
      {required this.name,
      required this.description,
      required this.price,
      this.imagePath});
}
