import 'package:flutter/material.dart';
import 'package:flutter_pokemon/controllers/favorite_controller.dart';
import 'package:flutter_pokemon/data/models/favorite_pokemon.dart';
import 'package:flutter_pokemon/data/models/pokemon_detail.dart';
import 'package:flutter_pokemon/data/repositories/favorite_pokemon_repository.dart';
import 'package:flutter_pokemon/data/repositories/pokemon_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final pokemonDetailProvider =
    FutureProvider.autoDispose.family<PokemonDetail, int>((ref, id) async {
  final repository = ref.watch(pokemonRepositoryProvider);
  return repository.fetchPokemonDetail(id);
});

class PokemonDetailScreen extends HookConsumerWidget {
  const PokemonDetailScreen({super.key, required this.pokemonId});

  final int pokemonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonDetailAsync = ref.watch(pokemonDetailProvider(pokemonId));
    final favoriteController = ref.read(favoriteControllerProvider.notifier);

    final favoriteListState = ref.watch(favoriteControllerProvider);
    final favoriteList = favoriteListState.asData?.value ?? [];
    final isFavorite =
        favoriteList.any((pokemon) => pokemon.pokemonId == pokemonId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ポケモン詳細'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.star,
              color: isFavorite ? Colors.yellow : Colors.grey,
            ),
            onPressed: () async {
              // お気に入りの追加・削除
              final pokemonDetail = pokemonDetailAsync.asData?.value;
              if (pokemonDetail != null) {
                if (isFavorite) {
                  await favoriteController.removeFavorite(pokemonId);
                } else {
                  await favoriteController.addFavorite(FavoritePokemon(
                    pokemonId: pokemonId,
                    name: pokemonDetail.name,
                    imageUrl: pokemonDetail.sprites.frontDefault,
                  ));
                }
                ref.invalidate(isFavoriteProvider(pokemonId));
              }
            },
          ),
        ],
      ),
      body: pokemonDetailAsync.when(
        data: (pokemonDetail) => ListView(
          children: [
            Image.network(
              pokemonDetail.sprites.frontDefault,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            ListTile(
              title: const Text('名前'),
              subtitle: Text(pokemonDetail.name),
            ),
            ListTile(
              title: const Text('高さ'),
              subtitle: Text('${pokemonDetail.height}m'),
            ),
            ListTile(
              title: const Text('重さ'),
              subtitle: Text('${pokemonDetail.weight}kg'),
            ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('エラーが発生しました'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.refresh(pokemonDetailProvider(pokemonId)),
                child: const Text('リトライ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
