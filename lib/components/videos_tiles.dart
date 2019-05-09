import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app_flutter/blocs/favorite_bloc.dart';
import 'package:youtube_app_flutter/models/video.dart';

class VideosTiles extends StatelessWidget {
  //const VideosTiles({Key key}) : super(key: key);

  final Video video;

  VideosTiles(this.video);

  @override
  Widget build(BuildContext context) {
    final blocFavorite = BlocProvider.of<FavoriteBloc>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(video.thumb, fit: BoxFit.cover),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        video.title,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(video.channel,
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.0)),
                    )
                  ],
                ),
              ),
              StreamBuilder<Map<String, Video>>(
                stream: blocFavorite.outFav,
                initialData: {},
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return IconButton(
                      icon: Icon(snapshot.data.containsKey(video.id)
                          ? Icons.star
                          : Icons.star_border),
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: () {
                        blocFavorite.toggleFavorite(video);
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.red[600])),
                    );
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
