import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final String text;

  const CustomTab({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 25,
      width: MediaQuery.of(context).size.width / 8,
      child: Tab(text: text),
    );
  }
}
