import 'package:flutter/material.dart';

Widget buildTextField({
  required String labelText,
  required String text,
  required double maxWidth,
  required void Function(String) onChanged,
  bool? enabled,
}) {
  return SizedBox(
    width: maxWidth,
    child: TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      initialValue: text,
      enabled: enabled ?? true,
      onChanged: onChanged,
    ),
  );
}
