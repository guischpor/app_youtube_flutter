import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_app_flutter/helpers/api.dart';
import 'package:youtube_app_flutter/models/video.dart';
import 'dart:async';

class VideosBloc implements BlocBase {
  Api api;

  List<Video> videos;

  final _videosController = StreamController<List<Video>>();
  //declarar uma variavel do tipo stream para saida
  Stream get outVideos => _videosController.stream;

  final _searchController = StreamController<String>();

  //declarar uma variavel do tipo sink para entrada
  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    api = Api();

    //função que retornara uma escuta caso o campo pesquisar receba algum valor
    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    //nesse if carregara os  videos da primeira pagina
    if (search != null) {
      //envia uma lista fazia antes da pesquisa
      _videosController.sink.add([]);

      //espera a nova pesquisa
      videos = await api.search(search);
      //no else carregara a proxima pagina com os videos
    } else {
      videos += await api.nextPage();
    }

    //logo realizar a pesquisa todos os videos vão ser adicionados a lista videos e ir para o outVideos
    _videosController.sink.add(videos);
  }

  /*todos os strems controller devem ser fechados*/
  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}
