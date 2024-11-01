import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@freezed
class Pokemon with _$Pokemon {
  const Pokemon._();

  const factory Pokemon({
    required String name,
    required String url,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  // URLからIDを取得するプロパティ
  String get pokemonIdString {
    final idString = RegExp(r'(\d+)/$').firstMatch(url)?.group(1);
    return idString ?? '';
  }

  // IDをint型で取得するプロパティ
  int get pokemonId => int.parse(pokemonIdString);
}
