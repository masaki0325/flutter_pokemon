import 'package:dio/dio.dart';
import 'package:flutter_pokemon/data/models/pokemon_detail.dart';
import 'package:flutter_pokemon/data/models/pokemon_list_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'pokemon_service.g.dart';

@RestApi(baseUrl: 'https://pokeapi.co/api/v2/')
abstract class PokemonService {
  factory PokemonService(
    Dio dio, {
    String baseUrl,
  }) = _PokemonService;

  @GET("pokemon")
  Future<PokemonListResponse> fetchPokemonList({
    @Query("limit") int limit = 20,
    @Query("offset") int offset = 0,
  });

  @GET("pokemon/{id}")
  Future<PokemonDetail> fetchPokemonDetail(@Path("id") int id);
}
