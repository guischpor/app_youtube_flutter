import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_app_flutter/models/video.dart';
//link1 utilizado para realizar a pesqusa dos videos
//"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"

//link2
//"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"

//link3 - link utilizado para retorna sugestões do campo de pesquisa
//"http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"

const API_KEY = 'AIzaSyDLEGmqkyAXpgNCERCdi0p6VwyaJpbV__s';

class Api {
  //função de busca dos vídeos do youtube
  search(String search) async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10");
    //decode serve para decodificar  o response
    return decode(response);
  }

  //essa função vai notificar se o codigo de resposto foi o codigo de 200, quer dizer que está ok.
  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      //nessa função retornara uma lista com todos os items que vamos usar
      List<Video> videos = decoded['items'].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();

      return videos;
    } else {
      throw Exception('Falha ao carregar os vídeos');
    }
  }
}
