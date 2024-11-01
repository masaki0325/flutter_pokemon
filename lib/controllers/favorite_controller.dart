import 'package:flutter_pokemon/data/models/favorite_pokemon.dart';
import 'package:flutter_pokemon/domain/usecases/favorite_pokemon_use_case.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final favoriteControllerProvider =
    StateNotifierProvider<FavoriteController, List<FavoritePokemon>>((ref) {
  final useCase = ref.watch(favoritePokemonUseCaseProvider);
  return FavoriteController(useCase);
});

class FavoriteController extends StateNotifier<List<FavoritePokemon>> {
  final FavoritePokemonUseCase _useCase;

  FavoriteController(this._useCase) : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favoriteList = await _useCase.getFavorites();
    state = favoriteList;
  }

  Future<void> addFavorite(FavoritePokemon pokemon) async {
    await _useCase.addFavorite(pokemon);
    state = [...state, pokemon];
  }

  Future<void> removeFavorite(int pokemonId) async {
    await _useCase.removeFavorite(pokemonId);
    state = state.where((pokemon) => pokemon.pokemonId != pokemonId).toList();
  }

  bool isFavorite(int pokemonId) {
    return state.any((pokemon) => pokemon.pokemonId == pokemonId);
  }

  Future<void> removeSelectedFavorites(List<int> selectedPokemonIds) async {
    await _useCase.removeFavorites(selectedPokemonIds);
    await _loadFavorites();
  }
}
