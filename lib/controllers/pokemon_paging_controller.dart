import 'package:flutter_pokemon/data/models/pokemon.dart';
import 'package:flutter_pokemon/data/repositories/pokemon_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final pagingControllerProvider = Provider((ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  final pagingController = PagingController<int, Pokemon>(firstPageKey: 0);

  // データ取得を行う関数
  Future<void> fetchPage(int pageKey) async {
    final result =
        await repository.fetchPokemonList(limit: 20, offset: pageKey);

    result.when(
      success: (pokemonList) {
        final isLastPage = pokemonList.length < 20;
        if (isLastPage) {
          pagingController.appendLastPage(pokemonList);
        } else {
          final nextPageKey = pageKey + 20;
          pagingController.appendPage(pokemonList, nextPageKey);
        }
      },
      failure: (error, stackTrace) {
        pagingController.error = error;
      },
    );
  }

  pagingController.addPageRequestListener((pageKey) async {
    await fetchPage(pageKey);
  });

  ref.onDispose(() => pagingController.dispose());

  return pagingController;
});
