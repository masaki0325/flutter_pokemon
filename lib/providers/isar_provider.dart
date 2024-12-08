import 'package:flutter_pokemon/data/models/favorite_pokemon.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_provider.g.dart';

@riverpod
Future<Isar> isar(IsarRef ref) async {
  final isar = await Isar.open(
    [FavoritePokemonSchema],
    directory: 'isar',
  );
  return isar;
}
