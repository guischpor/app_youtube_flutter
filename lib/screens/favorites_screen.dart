import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app_flutter/blocs/favorite_bloc.dart';
import 'package:youtube_app_flutter/models/video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube_app_flutter/helpers/api.dart';

class FavoriteScreen extends StatelessWidget {
  //const FavoriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocFavorite = BlocProvider.of<FavoriteBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Vídeos Favoritos'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: blocFavorite.outFav,
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            padding: EdgeInsets.only(left: 8.0),
            children: snapshot.data.values.map((v) {
              return InkWell(
                onTap: () {
                  FlutterYoutube.playYoutubeVideoById(
                      apiKey: API_KEY, videoId: v.id);
                },
                onLongPress: () {
                  blocFavorite.toggleFavorite(v);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(v.thumb),
                    ),
                    Expanded(
                      child: Text(
                        v.title,
                        style: TextStyle(color: Colors.white70),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
