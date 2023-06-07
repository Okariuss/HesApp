import 'package:desktop/core/constants/enums/local_keys_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalManager {
  SharedPreferences? _preferences;

  LocalManager._init() {
    SharedPreferences.getInstance().then((value) => _preferences = value);
  }

  static final LocalManager _instance = LocalManager._init();
  static LocalManager get instance => _instance;

  static Future preferencesInit() async {
    _instance._preferences = await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _preferences!.clear();
  }

  Future<void> clearAllSaveFirst() async {
    if (_preferences != null) {
      await _preferences!.clear();
      await setBoolValue(PreferencesKeys.IS_FIRST_APP, true);
    }
  }

  Future<void> setStringValue(PreferencesKeys key, String value) async {
    await _preferences!.setString(key.toString(), value);
  }

  Future<void> setBoolValue(PreferencesKeys key, bool value) async {
    await _preferences!.setBool(key.toString(), value);
  }

  String getStringValue(PreferencesKeys key) =>
      _preferences?.getString(key.toString()) ?? '';

  bool getBoolValue(PreferencesKeys key) =>
      _preferences?.getBool(key.toString()) ?? true;
}
