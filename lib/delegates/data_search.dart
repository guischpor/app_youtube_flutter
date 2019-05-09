import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate<String> {
  //1 função vai alterar os estados dos botões da appBar
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  //2 função, criara um botão que ficará no lado esquerdo de voltar
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  //3 retornara o resultado que escolhemos para a tela home com os videos carregados
  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context, query));
    return Container();
  }

  //4 - função que mostrara as sugestões na tela
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty)
      return Container();
    else
      return FutureBuilder<List>(
        future: suggestions(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data[index]),
                  leading: Icon(Icons.play_arrow),
                  onTap: () {
                    close(context, snapshot.data[index]);
                  },
                );
              },
              itemCount: snapshot.data.length,
            );
          }
        },
      );
  }

  //função que retornara segestões para pesquisa
  Future<List> suggestions(String search) async {
    http.Response response = await http.get(
        "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json");

    if (response.statusCode == 200) {
      return json.decode(response.body)[1].map((v) {
        return v[0];
      }).toList();
    } else {
      throw Exception('Falha ao carregar as sugestões');
    }
  }
}
