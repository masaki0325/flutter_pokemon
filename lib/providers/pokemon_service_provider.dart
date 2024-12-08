import 'package:flutter_pokemon/data/services/pokemon_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'dio_provider.dart';

part 'pokemon_service_provider.g.dart';

@riverpod
PokemonService pokemonService(PokemonServiceRef ref) {
  final dio = ref.watch(dioProvider);
  return PokemonService(dio);
}
