import 'package:flutter/material.dart';
import 'package:flutter_pokemon/controllers/favorite_controller.dart';
import 'package:flutter_pokemon/controllers/selected_pokemon_ids_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isEditModeProvider = StateProvider<bool>((ref) => false);

class FavoriteListScreen extends HookConsumerWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePokemonList = ref.watch(favoriteControllerProvider);
    final favoriteController = ref.read(favoriteControllerProvider.notifier);
    final selectedIdsProvider = ref.read(selectedPokemonIdsProvider.notifier);

    final isEditMode = ref.watch(isEditModeProvider);
    final selectedPokemonIds = ref.watch(selectedPokemonIdsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('お気に入り'),
        actions: [
          TextButton(
              onPressed: () {
                ref.read(isEditModeProvider.notifier).state = !isEditMode;
                selectedIdsProvider.clearSelection();
              },
              child: Text(isEditMode ? 'キャンセル' : '編集')),
          if (isEditMode && selectedPokemonIds.isNotEmpty)
            TextButton(
              child: const Text('削除'),
              onPressed: () async {
                await favoriteController
                    .removeSelectedFavorites(selectedPokemonIds);
                selectedIdsProvider.clearSelection();
              },
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: favoritePokemonList.length,
        itemBuilder: (context, index) {
          final favoritePokemon = favoritePokemonList[index];
          final isSelected =
              selectedPokemonIds.contains(favoritePokemon.pokemonId);

          return ListTile(
            leading: Image.network(
              favoritePokemon.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.broken_image,
                color: Colors.grey,
                size: 50,
              ),
            ),
            title: Text(favoritePokemon.name),
            tileColor: isSelected ? Colors.grey[300] : null,
            trailing: isEditMode
                ? Checkbox(
                    value: isSelected,
                    onChanged: (_) {
                      selectedIdsProvider
                          .toggleSelection(favoritePokemon.pokemonId);
                    })
                : const SizedBox.shrink(),
            onTap: () {
              if (isEditMode) {
                selectedIdsProvider.toggleSelection(favoritePokemon.pokemonId);
              }
            },
          );
        },
      ),
    );
  }
}
