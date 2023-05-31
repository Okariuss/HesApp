import 'package:desktop/core/constants/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Constants.primaryColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Constants.buttonTextColor,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Constants.buttonTextColor),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Constants.buttonTextColor),
      ),
    ),
    textSelectionTheme:
        TextSelectionThemeData(cursorColor: Constants.buttonTextColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size.fromHeight(60)),
        backgroundColor: MaterialStateProperty.all(Constants.buttonTextColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              side: const BorderSide(color: Constants.primaryColor),
              borderRadius: Constants.bigBorderRadius),
        ),
        foregroundColor:
            MaterialStateProperty.all(Constants.primaryColor), // Added line
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontWeight: Constants.bold,
            fontSize: Constants.contentSize,
          ),
        ),
      ),
    ),
  );
}
