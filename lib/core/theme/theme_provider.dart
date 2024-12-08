import 'package:flutter_pokemon/core/theme/theme_preference.dart';
import 'package:flutter_pokemon/core/utils/app_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  final ThemePreference _preference = ThemePreference();

  @override
  Future<bool> build() async {
    return await _preference.getTheme();
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    state = AsyncData(isDarkMode);
    await AppPreferences.setDarkTheme(isDarkMode);
  }
}
