import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._();

  static final AppPreferences instance = AppPreferences._();

  static late final SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isDarkTheme => _prefs.getBool(PrefKey.theme.key) ?? false;

  static Future<void> setDarkTheme(bool isDark) async {
    await _prefs.setBool(PrefKey.theme.key, isDark);
  }
}

enum PrefKey {
  theme;

  String get key => name;
}
