import 'package:flutter_pokemon/data/models/favorite_pokemon.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final favoritePokemonIsarProvider =
    Provider<Isar>((ref) => throw UnimplementedError());

final favoritePokemonProvider = Provider(
  (ref) => FavoritePokemonRepository(ref.watch(favoritePokemonIsarProvider)),
);

final isFavoriteProvider =
    FutureProvider.autoDispose.family<bool, int>((ref, pokemonId) async {
  final repository = ref.watch(favoritePokemonProvider);
  return await repository.isFavorite(pokemonId);
});

class FavoritePokemonRepository {
  final Isar _isar;

  FavoritePokemonRepository(this._isar);

  Future<void> addFavorite(FavoritePokemon pokemon) async {
    await _isar.writeTxn(() async {
      await _isar.favoritePokemons.put(pokemon);
    });
  }

  Future<void> removeFavorite(int pokemonId) async {
    await _isar.writeTxn(() async {
      await _isar.favoritePokemons
          .filter()
          .pokemonIdEqualTo(pokemonId)
          .deleteAll();
    });
  }

  Future<List<FavoritePokemon>> getFavorites() async {
    return await _isar.favoritePokemons.where().findAll();
  }

  Future<bool> isFavorite(int pokemonId) async {
    final count = await _isar.favoritePokemons
        .filter()
        .pokemonIdEqualTo(pokemonId)
        .count();
    return count > 0;
  }

  Future<void> removeFavorites(List<int> pokemonIds) async {
    if (pokemonIds.isEmpty) return;
    await _isar.writeTxn(() async {
      for (final pokemonId in pokemonIds) {
        await _isar.favoritePokemons
            .filter()
            .pokemonIdEqualTo(pokemonId)
            .deleteAll();
      }
    });
  }
}
