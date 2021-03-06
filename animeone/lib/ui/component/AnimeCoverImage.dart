import 'package:animeone/core/anime/AnimeVideo.dart';
import 'package:animeone/ui/page/video.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Takes an AnimeVideo object and render it to an Image
class AnimeCoverImage extends StatelessWidget {
  AnimeCoverImage({
    Key? key,
    required this.video,
  }) : super(key: key);

  final AnimeVideo? video;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Tooltip(
        message:
            this.shouldEnterPassword() ? '因版權方要求，目前無法提供此内容。' : '點擊進入内置視頻播放器',
        child: Stack(children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FittedBox(
                child: Image.asset('lib/assets/cover/${video?.image}.jpg'),
              ),
            ),
          ),
          Positioned.fill(
            child: this.renderButton(context, constraint),
          ),
        ]),
      );
    });
  }

  Widget renderButton(BuildContext context, BoxConstraints constraint) {
    if (this.shouldEnterPassword()) {
      return TextButton(
        child: Text(
          '啓動瀏覽器輸入密碼',
          style: TextStyle(
            backgroundColor: Colors.pink,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        onPressed: () {
          video?.launchURL();
        },
      );
    } else {
      return IconButton(
        onPressed: () {
          // video.launchURL();
          if (video?.isYoutube() ?? false) {
            video?.launchURL();
          } else {
            if (identical(0, 0.0)) {
              if (video != null && video!.video != null) launch(video!.video!);
            } else {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => Video(video: this.video),
                ),
              );
            }
          }
        },
        iconSize: constraint.maxWidth / 6,
        icon: Icon(Icons.play_circle_outline),
        color: Colors.pink,
      );
    }
  }

  bool shouldEnterPassword() {
    return this.video == null;
  }
}
