import 'package:flutter/material.dart';

Widget buildTextField(BuildContext context, String labelText, String text,
    Function(String) onChanged, double maxWidth) {
  return SizedBox(
    width: maxWidth < 600 ? double.infinity : maxWidth * 0.5,
    child: TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      initialValue: text,
      onChanged: onChanged,
    ),
  );
}
