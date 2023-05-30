import 'package:flutter/material.dart';

class Constants {
  // Text Sizes
  static const double titleSize = 24.0;
  static const double subtitleSize = 18.0;
  static const double contentSize = 16.0;

  // Font Weights
  static const FontWeight bold = FontWeight.bold;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight regular = FontWeight.normal;

  // Paddings
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets titlePadding =
      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
  static const EdgeInsets contentPadding =
      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
  static const EdgeInsets bigHorizontalSymmetricPadding =
      EdgeInsets.symmetric(horizontal: 40);
  static const EdgeInsets normalHorizontalSymmetricPadding =
      EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets smallHorizontalSymmetricPadding =
      EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets smallVerticalSymmetricPadding =
      EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsets normalVerticalSymmetricPadding =
      EdgeInsets.symmetric(vertical: 20);
  static const EdgeInsets bigVerticalSymmetricPadding =
      EdgeInsets.symmetric(vertical: 40);

  // Colors
  static const Color primaryColor = Colors.black;
  static const Color secondaryColor = Colors.white;
  static const Color buttonTextColor = Color(0xffffeb3f);
  static const Color errorColor = Colors.red;

  // Sizedbox
  static const SizedBox kdefaultSizedBoxSize = SizedBox(
    height: 32.0,
  );

  // RoundedRectangleBorder
  static RoundedRectangleBorder defaultRectangleRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  );

  // BorderRadius
  static BorderRadius defaultBorderRadius = BorderRadius.circular(20);
  static BorderRadius bigBorderRadius = BorderRadius.circular(40);
  static BorderRadius smallBorderRadius = BorderRadius.circular(10);
}
