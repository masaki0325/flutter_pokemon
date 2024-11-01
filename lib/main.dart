import 'package:flutter/material.dart';
import 'package:flutter_pokemon/app/app.dart';
import 'package:flutter_pokemon/core/utils/app_package_info.dart';
import 'package:flutter_pokemon/core/utils/app_preferences.dart';
import 'package:flutter_pokemon/data/models/favorite_pokemon.dart';
import 'package:flutter_pokemon/data/repositories/favorite_pokemon_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPackageInfo.initialize();
  await AppPreferences.initialize();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      FavoritePokemonSchema,
    ],
    directory: dir.path,
  );

  runApp(
    ProviderScope(
      overrides: [
        favoritePokemonIsarProvider.overrideWithValue(isar),
      ],
      child: const App(),
    ),
  );
}
