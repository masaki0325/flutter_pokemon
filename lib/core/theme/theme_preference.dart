import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const _themeKey = "isDarkTheme";

  setTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themeKey, isDarkMode);
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false;
  }
}
