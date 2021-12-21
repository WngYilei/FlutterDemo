import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xl_eyepetozer/modle/discovery/recommend_model.dart';
import 'package:xl_eyepetozer/utils/navigator_util.dart';
import 'package:xl_eyepetozer/weight/video/video_play_widget.dart';

class RecommendVideoPage extends StatefulWidget {
  final RecommendItem item;

  const RecommendVideoPage({Key key, this.item}) : super(key: key);

  @override
  _RecommendVideoPageState createState() => _RecommendVideoPageState();
}

class _RecommendVideoPageState extends State<RecommendVideoPage>
    with WidgetsBindingObserver {
  final GlobalKey<VideoPlayWidgetState> videokey = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      videokey.currentState.pause();
    } else if (state == AppLifecycleState.resumed) {
      videokey.currentState.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Stack(
            children: <Widget>[
              // Align：控制子View的位置，默认居中对齐
              Align(
                child: VideoPlayWidget(
                  key: videokey,
                  url: widget.item.data.content.data.playUrl,
                  // 是否允许全屏
                  allowFullScreen: !(widget.item.data.content.data.height >
                      widget.item.data.content.data.width),
                  // 视频的纵横比
                  aspectRatio: _getAspectRatio(),
                ),
              ),
              Positioned(
                left: 10,
                top: MediaQuery.of(context).padding.top + 10,
                child: GestureDetector(
                  onTap: () => back(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: 24,
                    height: 24,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getAspectRatio() {
    double aspectRatio = 16 / 9;
    bool allowFullScreen = widget.item.data.content.data.height >
        widget.item.data.content.data.width;
    if (allowFullScreen) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      aspectRatio = width / height;
    }
    return aspectRatio;
  }
}
