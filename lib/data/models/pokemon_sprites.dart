import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_sprites.freezed.dart';
part 'pokemon_sprites.g.dart';

@freezed
class PokemonSprites with _$PokemonSprites {
  const factory PokemonSprites({
    @JsonKey(name: 'front_default') required String frontDefault,
    @JsonKey(name: 'back_default') required String backDefault,
    @JsonKey(name: 'front_shiny') required String frontShiny,
    @JsonKey(name: 'back_shiny') required String backShiny,
  }) = _PokemonSprites;

  factory PokemonSprites.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpritesFromJson(json);
}
