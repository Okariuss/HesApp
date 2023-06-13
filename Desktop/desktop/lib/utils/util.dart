import 'package:shared_preferences/shared_preferences.dart';

class Me {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String get token => _preferences.getString('token') ?? '';
  static String get userName => _preferences.getString('userName') ?? '';
  static String get mail => _preferences.getString('mail') ?? '';
  static String get password => _preferences.getString('password') ?? '';
  static String get phone => _preferences.getString('phone') ?? '';
  static String get restaurantName =>
      _preferences.getString('restaurantName') ?? '';
  static String get restaurantDescription =>
      _preferences.getString('restaurantDescription') ?? '';
  static String get restaurantAddress =>
      _preferences.getString('restaurantAddress') ?? '';
  static String get restaurantPhone =>
      _preferences.getString('restaurantPhone') ?? '';

  static Future<void> setToken(String newToken) async {
    await _preferences.setString('token', newToken);
  }

  static Future<void> setUserName(String newUserName) async {
    await _preferences.setString('userName', newUserName);
  }

  static Future<void> setMail(String newMail) async {
    await _preferences.setString('mail', newMail);
  }

  static Future<void> setPassword(String newPassword) async {
    await _preferences.setString('password', newPassword);
  }

  static Future<void> setPhone(String newPhone) async {
    await _preferences.setString('phone', newPhone);
  }

  static Future<void> setRestaurantName(String newRestaurantName) async {
    await _preferences.setString('restaurantName', newRestaurantName);
  }

  static Future<void> setRestaurantDescription(
      String newRestaurantDescription) async {
    await _preferences.setString(
        'restaurantDescription', newRestaurantDescription);
  }

  static Future<void> setRestaurantAddress(String newRestaurantAddress) async {
    await _preferences.setString('restaurantAddress', newRestaurantAddress);
  }

  static Future<void> setRestaurantPhone(String newRestaurantPhone) async {
    await _preferences.setString('restaurantPhone', newRestaurantPhone);
  }
}
