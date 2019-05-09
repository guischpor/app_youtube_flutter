import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_app_flutter/helpers/api.dart';
import 'package:youtube_app_flutter/models/video.dart';
import 'dart:async';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorite = {};

  final _favController = StreamController<Map<String, Video>>.broadcast();
  Stream<Map<String, Video>> get outFav => _favController.stream;

  //função que habilita o botão de favorito, assim add os videos ao fav
  void toggleFavorite(Video video) {
    //se o meu video ja existir na lista de fav, então ele vai remover
    if (_favorite.containsKey(video.id)) {
      _favorite.remove(video.id);
    }
    //caso não exista o video nos favs então ele add o video a lista
    else {
      _favorite[video.id] = video;
    }

    //depois disso add a lista de favs a lista
    _favController.sink.add(_favorite);
  }

  @override
  void dispose() {
    _favController.close();
  }
}
