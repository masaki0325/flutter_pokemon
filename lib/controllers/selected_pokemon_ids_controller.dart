import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedPokemonIdsProvider =
    StateNotifierProvider.autoDispose<SelectedPokemonIdsNotifier, List<int>>(
        (ref) {
  return SelectedPokemonIdsNotifier();
});

class SelectedPokemonIdsNotifier extends StateNotifier<List<int>> {
  SelectedPokemonIdsNotifier() : super([]);

  // ポケモンIDの選択・解除トグル処理
  void toggleSelection(int pokemonId) {
    if (state.contains(pokemonId)) {
      state = state.where((id) => id != pokemonId).toList();
    } else {
      state = [...state, pokemonId];
    }
  }

  // 選択状態をリセット
  void clearSelection() {
    state = [];
  }
}
