import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app_flutter/blocs/favorite_bloc.dart';
import 'package:youtube_app_flutter/blocs/videos_bloc.dart';
import 'package:youtube_app_flutter/components/videos_tiles.dart';
import 'package:youtube_app_flutter/delegates/data_search.dart';
import 'package:youtube_app_flutter/models/video.dart';

class HomeScreen extends StatelessWidget {
  //const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VideosBloc>(context);
    final blocFavorite = BlocProvider.of<FavoriteBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Image.asset(
            'images/logoRgb.png',
            height: 25,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: blocFavorite.outFav,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("${snapshot.data.length}");
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) bloc.inSearch.add(result);
            },
          )
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
        stream: bloc.outVideos,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                //esse se a lista de video estiver até o 9, está na primeira pagina
                if (index < snapshot.data.length) {
                  return VideosTiles(snapshot.data[index]);
                }
                //caso contrário ele tentara encontrar o novo video, ele  tentara buscar esse dado
                else if (index > 1) {
                  //ele retornara apenas a pagina nova
                  bloc.inSearch.add(null);
                  return Container(
                    height: 40.0,
                    width: 40.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.red[600]),
                    ),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
