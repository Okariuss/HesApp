import 'package:flutter/material.dart';

Widget buildTextField(BuildContext context, String labelText, String text,
    double maxWidth, Function(String) onChanged) {
  return SizedBox(
    width: maxWidth,
    child: TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      initialValue: text,
      onChanged: onChanged,
    ),
  );
}
