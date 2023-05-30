import 'package:flutter/material.dart';

class SettingsModel {
  String userName;
  String password;
  String email;
  String restaurantName;
  String restaurantContact;
  String restaurantLocation;
  List<String> openingDays;
  Map<String, RangeValues> openingHours;

  SettingsModel({
    this.userName = '',
    this.password = '',
    this.email = '',
    this.restaurantName = '',
    this.restaurantContact = '',
    this.restaurantLocation = '',
    this.openingDays = const [],
    this.openingHours = const {},
  });
}
