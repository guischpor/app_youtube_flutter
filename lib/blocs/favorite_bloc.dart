import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_app_flutter/helpers/api.dart';
import 'package:youtube_app_flutter/models/video.dart';
import 'dart:async';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorite = {
    
  };

  @override
  void dispose() {}
}
