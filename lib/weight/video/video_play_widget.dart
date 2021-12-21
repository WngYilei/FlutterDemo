import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:chewie/src/material/material_progress_bar.dart'; // chewie 2.12 导包
import 'package:video_player/video_player.dart';
import 'package:xl_eyepetozer/weight/video/video_controls_widget.dart';

class VideoPlayWidget extends StatefulWidget {
  final String url;
  final bool autoPlay;
  final bool looping;
  final bool allowFullScreen;
  final bool allowPlaybackSpeedChanging;
  final double aspectRatio;

  const VideoPlayWidget(
      {Key key,
      this.url,
      this.autoPlay = true,
      this.looping = true,
      this.allowFullScreen = true,
      this.allowPlaybackSpeedChanging = true,
      this.aspectRatio = 16 / 9})
      : super(key: key);

  @override
  VideoPlayWidgetState createState() => VideoPlayWidgetState();
}

class VideoPlayWidgetState extends State<VideoPlayWidget> {
  VideoPlayerController _videoPlayerController;
  ChewieController _cheWieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _cheWieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      aspectRatio: widget.aspectRatio,
      allowPlaybackSpeedChanging: widget.allowPlaybackSpeedChanging,
      allowFullScreen: widget.allowFullScreen,
      customControls: VideoControlsWidget(
        overlayUI: _videoPlayTopBar(),
        bottomGradient: _blackLinearGradient(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width / widget.aspectRatio;
    return Container(
      width: width,
      height: height,
      child: Chewie(
        controller: _cheWieController,
      ),
    );
  }

  void pause() {
    _videoPlayerController.pause();
  }

  void play() {
    _cheWieController.play();
  }

  void dispose() {
    _videoPlayerController.dispose();
  }

  /// 播放视频的 TopBar
  Widget _videoPlayTopBar() {
    return Container(
      padding: EdgeInsets.only(right: 8),
      // 渐变背景色
      decoration: BoxDecoration(gradient: _blackLinearGradient(fromTop: true)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackButton(color: Colors.white),
          // Icon(Icons.more_vert_rounded, color: Colors.white, size: 20),
        ],
      ),
    );
  }

  /// 渐变背景色
  _blackLinearGradient({bool fromTop = false}) {
    return LinearGradient(
      begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
      end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
      colors: [
        Colors.black54,
        Colors.black45,
        Colors.black38,
        Colors.black26,
        Colors.black12,
        Colors.transparent
      ],
    );
  }
}
