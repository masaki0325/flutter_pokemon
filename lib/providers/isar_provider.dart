import 'package:flutter_pokemon/data/models/favorite_pokemon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

final isarProvider = Provider<Future<Isar>>((ref) async {
  final isar = await Isar.open([
    FavoritePokemonSchema,
  ], directory: 'isar');
  return isar;
});
