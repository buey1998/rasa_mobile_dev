import 'package:bueytest/bloc/pokemon_bloc.dart';
import 'package:bueytest/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPokemaon extends StatefulWidget {
  final url;
  DetailPokemaon({Key? key, this.url}) : super(key: key);

  @override
  _DetailPokemaonState createState() => _DetailPokemaonState();
}

class _DetailPokemaonState extends State<DetailPokemaon> {
  PokemonBloc pokemonBloc = PokemonBloc();
  var _children = <Widget>[];
  @override
  void initState() {
    super.initState();
    pokemonBloc.add(GetDetail(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายละเอียด',
          style: wh20Style,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PokemonBloc, PokemonState>(
        bloc: pokemonBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ShowDetailPokemon) {
            _children = [
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[200],
                // child: Image.network('${state.pokemonDetailModel.abilities}'),
              ),
              // ...List.generate(
              //     state.pokemonDetailModel.abilities!.length,
              //     (index) => Image.network(
              //         '${state.pokemonDetailModel.abilities![index].ability!.url}')),
              Divider(
                color: Colors.white,
              ),
              Center(
                child: Text(
                  '${state.pokemonDetailModel.name}',
                  style: pk15Style,
                ),
              ),
              detailsData(context, state, 'HP', state.pokemonDetailModel.name),
              detailsData(
                  context, state, 'Attack', state.pokemonDetailModel.name),
              detailsData(
                  context, state, 'Defense', state.pokemonDetailModel.name),
              detailsData(
                  context, state, 'Speed', state.pokemonDetailModel.name),
              detailsData(context, state, 'Special Attack',
                  state.pokemonDetailModel.name),
              detailsData(context, state, 'Special Defense',
                  state.pokemonDetailModel.name),
              SizedBox(
                height: 15,
              ),
              Text(
                'ข้อมูล',
                style: pk15Style,
              ),
              Text(
                'ข้อมูล',
                style: bl11Style,
              ),
            ];
          } else {}
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              shrinkWrap: true,
              children: _children,
            ),
          );
        },
      ),
    );
  }

  Row detailsData(
      BuildContext context, ShowDetailPokemon state, testName, testDetail) {
    return Row(
      children: [
        Container(
            // color: Colors.black,
            width: MediaQuery.of(context).size.width / 5 * 1.8,
            child: Text(
              testName,
              style: bl113Style,
            )),
        Container(
            // color: Colors.black,
            width: MediaQuery.of(context).size.width / 5 * 2.8,
            child: Text(
              testDetail,
              style: bl113Style,
            ))
      ],
    );
  }
}
