import 'package:desktop/models/settings.dart';
import 'package:flutter/material.dart';

SettingsModel settings = SettingsModel(
  openingDays: [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ],
  openingHours: {
    'Monday': const RangeValues(0, 0),
    'Tuesday': const RangeValues(0, 0),
    'Wednesday': const RangeValues(0, 0),
    'Thursday': const RangeValues(0, 0),
    'Friday': const RangeValues(0, 0),
    'Saturday': const RangeValues(0, 0),
    'Sunday': const RangeValues(0, 0),
  },
);

class SettingsViewModel extends ChangeNotifier {
  void updateUsername(String username) {
    settings.userName = username;
    notifyListeners();
  }

  void updateEmail(String email) {
    settings.email = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    settings.password = password;
    notifyListeners();
  }

  void updateRestaurantName(String name) {
    settings.restaurantName = name;
    notifyListeners();
  }

  void updateRestaurantContact(String contact) {
    settings.restaurantContact = contact;
    notifyListeners();
  }

  void updateRestaurantLocation(String location) {
    settings.restaurantLocation = location;
    notifyListeners();
  }

  void updateOpeningHours(String day, RangeValues values) {
    settings.openingHours[day] = values;
    notifyListeners();
  }

  void addOpeningDay(String day) {
    if (!settings.openingDays.contains(day)) {
      settings.openingDays.add(day);
      notifyListeners();
    }
  }

  void saveSettings() {
    SettingsModel updatedSettings = SettingsModel(
        openingDays: List<String>.from(settings.openingDays),
        openingHours: Map<String, RangeValues>.from(settings.openingHours),
        restaurantName: settings.restaurantName,
        restaurantContact: settings.restaurantContact,
        restaurantLocation: settings.restaurantLocation,
        email: settings.email,
        password: settings.password,
        userName: settings.userName);

    settings = updatedSettings;
    notifyListeners();
  }
}
