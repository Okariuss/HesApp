import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final String text;

  CustomTab({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: MediaQuery.of(context).size.width / 8,
      child: Tab(text: text),
    );
  }
}
