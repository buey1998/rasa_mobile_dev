part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

class GetPokemon extends PokemonEvent {
  final int limit;
  GetPokemon(this.limit);
}

class GetDetail extends PokemonEvent {
  final String url;
  GetDetail(this.url);
}
