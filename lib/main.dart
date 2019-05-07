import 'package:flutter/material.dart';
import 'package:youtube_app_flutter/helpers/api.dart';
import 'package:youtube_app_flutter/screens/home_screen.dart';

void main() {
  Api api = Api();
  api.search('eletro');
  runApp(YotubeAppFlutter());
}

class YotubeAppFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Youtube Flutter',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
