part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class ShowPokemon extends PokemonState {
  final PokemonModel pokemonModel;
  ShowPokemon(this.pokemonModel);
}

class ShowDetailPokemon extends PokemonState {
  final PokemonDetailModel pokemonDetailModel;
  ShowDetailPokemon(this.pokemonDetailModel);
}

class PokemonInprogress extends PokemonState {}
