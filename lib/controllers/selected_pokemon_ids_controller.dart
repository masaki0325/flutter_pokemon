import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_pokemon_ids_controller.g.dart';

@riverpod
class SelectedPokemonIds extends _$SelectedPokemonIds {
  // 初期状態を返す
  @override
  List<int> build() {
    return [];
  }

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
