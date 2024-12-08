import 'package:flutter_pokemon/data/models/favorite_pokemon.dart';
import 'package:flutter_pokemon/domain/usecases/favorite_pokemon_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_controller.g.dart';

@riverpod
class FavoriteController extends _$FavoriteController {
  late final FavoritePokemonUseCase _useCase;

  @override
  Future<List<FavoritePokemon>> build() async {
    _useCase = ref.watch(favoritePokemonUseCaseProvider);
    return _useCase.getFavorites();
  }

  Future<void> refreshFavorites() async {
    state = const AsyncValue.loading();
    try {
      final favoriteList = await _useCase.getFavorites();
      state = AsyncData(favoriteList);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addFavorite(FavoritePokemon pokemon) async {
    if (state.isLoading) return;
    final currentData = state.asData?.value ?? [];
    try {
      await _useCase.addFavorite(pokemon);
      state = AsyncValue.data([...currentData, pokemon]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> removeFavorite(int pokemonId) async {
    if (state.isLoading) return;
    final currentData = state.asData?.value ?? [];
    try {
      await _useCase.removeFavorite(pokemonId);
      state = AsyncValue.data(
        currentData.where((pokemon) => pokemon.pokemonId != pokemonId).toList(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  bool isFavorite(int pokemonId) {
    final currentData = state.asData?.value ?? [];
    return currentData.any((pokemon) => pokemon.pokemonId == pokemonId);
  }

  Future<void> removeSelectedFavorites(List<int> selectedPokemonIds) async {
    try {
      await _useCase.removeFavorites(selectedPokemonIds);
      await refreshFavorites();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
