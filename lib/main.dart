import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app_flutter/blocs/videos_bloc.dart';
import 'package:youtube_app_flutter/helpers/api.dart';
import 'package:youtube_app_flutter/screens/home_screen.dart';

void main() {
  runApp(YotubeAppFlutter());
}

class YotubeAppFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: MaterialApp(
        title: 'App Youtube Flutter',
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
