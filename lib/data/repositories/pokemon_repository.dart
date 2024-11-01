import 'package:flutter_pokemon/core/utils/result.dart';
import 'package:flutter_pokemon/data/models/pokemon.dart';
import 'package:flutter_pokemon/data/models/pokemon_detail.dart';
import 'package:flutter_pokemon/data/services/api_helper.dart';
import 'package:flutter_pokemon/data/services/pokemon_service.dart';
import 'package:flutter_pokemon/providers/pokemon_service_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final pokemonRepositoryProvider = Provider((ref) {
  final pokemonService = ref.watch(pokemonServiceProvider);
  return PokemonRepository(pokemonService);
});

class PokemonRepository {
  final PokemonService _service;

  PokemonRepository(this._service);

  Future<Result<List<Pokemon>>> fetchPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final response =
          await _service.fetchPokemonList(limit: limit, offset: offset);
      return Result.success(response.results);
    } catch (error, stackTrace) {
      return Result.failure(error, stackTrace);
    }
  }

  Future<PokemonDetail> fetchPokemonDetail(int id) async {
    return ApiHelper.handleErrors(() async {
      return await _service.fetchPokemonDetail(id);
    });
  }
}
