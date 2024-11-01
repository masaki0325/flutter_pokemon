import 'package:flutter/material.dart';
import 'package:flutter_pokemon/core/theme/theme_provider.dart';
import 'package:flutter_pokemon/core/utils/app_package_info.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingScreen extends HookConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("設定"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("バージョン"),
            trailing: Text(AppPackageInfo.versionString),
          ),
          ListTile(
            title: const Text("ビルド番号"),
            trailing: Text(AppPackageInfo.buildNumber),
          ),
          const Divider(),
          ListTile(
            title: const Text("テーマ"),
            subtitle: Text(isDarkMode ? "ダークテーマ" : "ライトテーマ"),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) =>
                  ref.read(themeProvider.notifier).toggleTheme(value),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
