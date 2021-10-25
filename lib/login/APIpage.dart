import 'package:bueytest/bloc/pokemon_bloc.dart';
import 'package:bueytest/login/details.dart';
import 'package:bueytest/style/textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class APIPage extends StatefulWidget {
  final user;
  APIPage({Key? key, this.user}) : super(key: key);

  @override
  _APIPageState createState() => _APIPageState();
}

int limit = 10;

class _APIPageState extends State<APIPage> {
  PokemonBloc pokemonBloc = PokemonBloc();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  var _children = <Widget>[];
  final _scrollController = ScrollController();
  final _scrollThrehold = 10;
  bool _loading = false;

  @override
  void initState() {
    _scrollController.addListener(() async {
      final maxScroll = _scrollController.position.maxScrollExtent;
      print('Max Scroll :$maxScroll');
      final currentScroll = _scrollController.position.pixels;
      print("CurrentScroll:$currentScroll");
      if (maxScroll - currentScroll <= _scrollThrehold) {
        pokemonBloc.add(GetPokemon(limit += 10));
      }
    });
    super.initState();
    pokemonBloc.add(GetPokemon(limit));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'รายชื่อโปเกม่อน',
          style: wh20Style,
        ),
        centerTitle: true,
      ),
      // body: Image.network(
      //     'https://assets-global.website-files.com/5e3c45dea042cf97f3689681/5e417cd336a72b06a86c73e7_Flutter-Tutorial-Header%402x.jpg'),
      body: BlocConsumer<PokemonBloc, PokemonState>(
        bloc: pokemonBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ShowPokemon) {
            _children = List.generate(
                state.pokemonModel.results!.length + 1,
                (index) => index < state.pokemonModel.results!.length
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPokemaon(
                                      url: state
                                          .pokemonModel.results![index].url)));
                        },
                        child: Card(
                            elevation: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: GridTile(
                                    child: Image.network(
                                        '${state.pokemonModel.results![index].url}'),
                                  ),
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Center(
                                        child: Text(
                                      '${state.pokemonModel.results![index].name}',
                                      style: bl11Style,
                                    )))
                              ],
                            )),
                      )
                    : Center(child: CircularProgressIndicator())).toList();
          } else {}
          return Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (context, snapshot) {
                    return Container(
                      color: Colors.grey[200],
                      height: 50,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${widget.user}'),
                              ],
                            ),
                            // Align(
                            //     alignment: Alignment.centerRight,
                            //     child: Icon(Icons.logout))
                          ],
                        ),
                      ),
                    );
                  }),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  children: _children,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
