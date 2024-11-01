import 'package:isar/isar.dart';

part 'favorite_pokemon.g.dart';

@Collection()
class FavoritePokemon {
  Id id = Isar.autoIncrement;

  int pokemonId;
  String name;
  String imageUrl;

  FavoritePokemon({
    required this.pokemonId,
    required this.name,
    required this.imageUrl,
  });
}
