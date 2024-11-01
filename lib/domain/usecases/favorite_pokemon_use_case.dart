import 'package:flutter_pokemon/data/models/favorite_pokemon.dart';
import 'package:flutter_pokemon/data/repositories/favorite_pokemon_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final favoritePokemonUseCaseProvider = Provider((ref) {
  final repository = ref.watch(favoritePokemonProvider);
  return FavoritePokemonUseCase(repository);
});

class FavoritePokemonUseCase {
  final FavoritePokemonRepository _repository;

  FavoritePokemonUseCase(this._repository);

  Future<List<FavoritePokemon>> getFavorites() async {
    return await _repository.getFavorites();
  }

  Future<void> addFavorite(FavoritePokemon pokemon) async {
    await _repository.addFavorite(pokemon);
  }

  Future<void> removeFavorite(int pokemonId) async {
    await _repository.removeFavorite(pokemonId);
  }

  Future<bool> isFavorite(int pokemonId) async {
    return await _repository.isFavorite(pokemonId);
  }

  Future<void> removeFavorites(List<int> selectedPokemonIds) async {
    await _repository.removeFavorites(selectedPokemonIds);
  }
}
