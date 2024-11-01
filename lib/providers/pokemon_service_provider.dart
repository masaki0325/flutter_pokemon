import 'package:flutter_pokemon/data/services/pokemon_service.dart';
import 'package:flutter_pokemon/providers/dio_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final pokemonServiceProvider = Provider<PokemonService>((ref) {
  final dio = ref.watch(dioProvider);
  return PokemonService(dio);
});
