import 'package:flutter_pokemon/data/models/favorite_pokemon.dart';
import 'package:flutter_pokemon/data/repositories/favorite_pokemon_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_pokemon_use_case.g.dart';

@riverpod
FavoritePokemonUseCase favoritePokemonUseCase(FavoritePokemonUseCaseRef ref) {
  final repository = ref.watch(favoritePokemonProvider);
  return FavoritePokemonUseCase(repository);
}

class FavoritePokemonUseCase {
  final FavoritePokemonRepository _repository;

  FavoritePokemonUseCase(this._repository);

  Future<List<FavoritePokemon>> getFavorites() => _repository.getFavorites();

  Future<void> addFavorite(FavoritePokemon pokemon) =>
      _repository.addFavorite(pokemon);

  Future<void> removeFavorite(int pokemonId) =>
      _repository.removeFavorite(pokemonId);

  Future<bool> isFavorite(int pokemonId) => _repository.isFavorite(pokemonId);

  Future<void> removeFavorites(List<int> selectedPokemonIds) =>
      _repository.removeFavorites(selectedPokemonIds);
}
