import 'package:flutter/material.dart';
import 'package:flutter_pokemon/core/theme/theme.dart';
import 'package:flutter_pokemon/core/theme/theme_provider.dart';
import 'package:flutter_pokemon/presentation/screens/main_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeNotifierProvider);
    final isDarkMode = themeState.asData?.value ?? false;

    return MaterialApp(
      theme: customLightTheme,
      darkTheme: customDarkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MainScreen(),
    );
  }
}
