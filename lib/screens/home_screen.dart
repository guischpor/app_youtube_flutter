import 'package:flutter/material.dart';
import 'package:youtube_app_flutter/delegates/data_search.dart';

class HomeScreen extends StatelessWidget {
  //const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Text('0'),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      backgroundColor: Colors.black87,
      body: Container(),
    );
  }
}
