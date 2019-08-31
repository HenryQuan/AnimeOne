import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

/// This class save the video link and randomly choose one of the cover images
class AnimeVideo {

  String video;
  int image;

  final _covers = [5, 6, 7, 8, 9];

  AnimeVideo(String video) {
    this.video = video;
    this.image = _covers[Random().nextInt(5)];
  }

  AnimeVideo.fromJson(Map<String, dynamic> json) : 
    video = json['video'],
    image = json['image'];

  Map<String, dynamic> toJson() =>
  {
    'video': video,
    'image': image,
  };

  void launchURL() {
    launch(this.video);
  }

}