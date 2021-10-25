import 'package:bloc/bloc.dart';
import 'package:bueytest/login/details.dart';
import 'package:bueytest/model/detailPokemon.dart';
import 'package:bueytest/model/pokemonmModel.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(PokemonInitial()) {
    on<GetPokemon>((event, emit) async {
      emit(PokemonInprogress());
      // TODO: implement event handler
      var result = await fetchAlbum(event.limit);
      print(result.statusCode);
      if (result.statusCode == 200) {
        PokemonModel pokemonModel = pokemonModelFromJson(result.body);
        emit(ShowPokemon(pokemonModel));
      } else {}
    });
    on<GetDetail>((event, emit) async {
      var result = await fetchDetailPokemon(event.url);
      print(result.statusCode);
      if (result.statusCode == 200) {
        PokemonDetailModel pokemonDetailModel =
            pokemonDetailModelFromJson(result.body);
        emit(ShowDetailPokemon(pokemonDetailModel));
      } else {}
    });
  }
  Future<http.Response> fetchAlbum(limit) {
    try {
      return http
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/?limit=$limit'));
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<http.Response> fetchDetailPokemon(url) {
    try {
      return http.get(Uri.parse(url));
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
