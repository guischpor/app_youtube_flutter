import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_app_flutter/helpers/api.dart';
import 'package:youtube_app_flutter/models/video.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorites = {};

  final _favController = BehaviorSubject<Map<String, Video>>(seedValue: {});
  Stream<Map<String, Video>> get outFav => _favController.stream;

  //função que salvara permanentemente os favoritos a lista
  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      //prefs.clear();
      if (prefs.getKeys().contains('favorites')) {
        //nesse ponto estamos convertendo o _favorite em um mapa
        _favorites = json.decode(prefs.getString('favorites')).map((k, v) {
          return MapEntry(k, Video.fromJson(v));
        }).cast<String, Video>();

        //apos carregar toda a lista de favs, ele vai adicionar o novo video a lista
        _favController.add(_favorites);
      }
    });
  }

  //função que habilita o botão de favorito, assim add os videos ao fav
  void toggleFavorite(Video video) {
    //se o meu video ja existir na lista de fav, então ele vai remover
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    }
    //caso não exista o video nos favs então ele add o video a lista
    else {
      _favorites[video.id] = video;
    }

    //depois disso add a lista de favs a lista
    _favController.sink.add(_favorites);

    //nessa parte realmente a lista de videos sera salvos em favoritos
    _savedFav();
  }

  //função salvar os videos na lista
  void _savedFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('favorites', json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    _favController.close();
  }
}
