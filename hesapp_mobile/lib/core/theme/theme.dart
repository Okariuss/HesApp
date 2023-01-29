import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hesapp_mobile/core/constants/constants.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData.light().copyWith(
      colorScheme: const ColorScheme.light(
        primary: Colors.black,
        secondary: Colors.white,
        error: Color(0xffec1d25),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: true,
        toolbarHeight: 70,
        elevation: 0,
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: primaryColor,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            labelLarge: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
            labelMedium: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: primaryColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))))));
}