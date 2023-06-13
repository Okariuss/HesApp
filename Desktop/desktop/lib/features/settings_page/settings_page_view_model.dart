import 'dart:developer';

import 'package:desktop/features/settings_page/settings_page_service.dart';
import 'package:desktop/utils/util.dart';
import 'package:flutter/material.dart';

import 'settings_page.dart';

class SettingsViewModel extends ChangeNotifier {
  StaffModel? staff;

  Future<void> fetchStaffDetails() async {
    try {
      staff = await SettingsService.getStaffDetails();
      notifyListeners();
    } catch (error) {
      // Handle error
    }
  }

  Future<void> updateStaffDetails(StaffModel staffData) async {
    try {
      await SettingsService.updateStaffDetails(staffData);
      // Fetch updated staff details
      await fetchStaffDetails();
    } catch (error) {
      // Handle error
    }
  }

  // Add methods to update individual fields as needed
  void updateUsername(String username) {
    if (staff != null) {
      staff!.username = username;
      Me.setUserName(username);
      notifyListeners();
    }
  }

  void updateEmail(String email) {
    if (staff != null) {
      staff!.email = email;
      Me.setMail(email);
      notifyListeners();
    }
  }

  void updatePassword(String password) {
    // Update password logic here
    if (staff != null) {
      staff!.password = password;
      Me.setPassword(password);
      notifyListeners();
    }
  }

  void updateRestaurantName(String name) {
    if (staff != null) {
      staff!.restaurantName = name;
      Me.setRestaurantName(name);
      notifyListeners();
    }
  }

  void updateRestaurantContact(String contact) {
    // Update restaurant contact logic here
    if (staff != null) {
      staff!.restaurantPhone = contact;
      Me.setRestaurantPhone(contact);
      notifyListeners();
    }
  }

  void updateRestaurantLocation(String location) {
    // Update restaurant location logic here
    if (staff != null) {
      staff!.restaurantAddress = location;
      Me.setRestaurantAddress(location);
      notifyListeners();
    }
  }

  void updatePhone(String phone) {
    // Update restaurant location logic here
    if (staff != null) {
      staff!.phone = phone;
      Me.setPhone(phone);
      notifyListeners();
    }
  }

  void updateDescription(String description) {
    // Update restaurant location logic here
    if (staff != null) {
      staff!.restaurantDescription = description;
      Me.setRestaurantDescription(description);
      notifyListeners();
    }
  }

  // Add additional methods for other fields

  // Save the settings
  Future<void> saveSettings() async {
    if (staff != null) {
      try {
        await updateStaffDetails(staff!);
      } catch (error) {
        // Handle error
      }
    }
  }
}
