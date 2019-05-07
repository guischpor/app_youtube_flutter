import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  //const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/logoRgb.png'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
    );
  }
}
