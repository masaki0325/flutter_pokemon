import 'package:flutter/material.dart';
import 'package:flutter_pokemon/presentation/screens/favorite_list_screen.dart';
import 'package:flutter_pokemon/presentation/screens/pokemon_list_screen.dart';
import 'package:flutter_pokemon/presentation/screens/setting_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  static const List _widgetOptions = [
    PokemonListScreen(),
    FavoriteListScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      body: _widgetOptions[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '一覧',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'お気に入り',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: (index) {
          ref.read(selectedIndexProvider.notifier).state = index;
        },
      ),
    );
  }
}
