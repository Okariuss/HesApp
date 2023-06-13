import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final Color cursorColor;
  final String labelText;
  final Color labelColor;
  final Color focusedBorderColor;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.obscureText = false,
    required this.cursorColor,
    required this.labelText,
    required this.labelColor,
    required this.focusedBorderColor,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(color: widget.labelColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.focusedBorderColor,
          ),
        ),
      ),
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
    );
  }
}
