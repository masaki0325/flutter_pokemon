import 'package:flutter_pokemon/core/theme/theme_preference.dart';
import 'package:flutter_pokemon/core/utils/app_preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  final ThemePreference _preference = ThemePreference();

  ThemeNotifier() : super(false) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final theme = await _preference.getTheme();
    state = theme;
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    state = isDarkMode;
    AppPreferences.setDarkTheme(isDarkMode);
  }
}
