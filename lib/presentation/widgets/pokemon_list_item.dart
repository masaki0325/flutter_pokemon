import 'package:flutter/material.dart';
import 'package:flutter_pokemon/data/models/pokemon.dart';
import 'package:flutter_pokemon/data/repositories/favorite_pokemon_repository.dart';
import 'package:flutter_pokemon/presentation/screens/pokemon_detail_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PokemonListItem extends HookConsumerWidget {
  final Pokemon pokemon;

  const PokemonListItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite =
        ref.watch(isFavoriteProvider(pokemon.pokemonId)).value ?? false;

    return ListTile(
      leading: Text(pokemon.pokemonIdString),
      title: Text(pokemon.name),
      trailing: Icon(
        isFavorite ? Icons.star : Icons.star_border,
        color: isFavorite ? Colors.yellow : null,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PokemonDetailScreen(pokemonId: pokemon.pokemonId),
          ),
        );
      },
    );
  }
}
