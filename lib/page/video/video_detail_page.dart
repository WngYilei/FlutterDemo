import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xl_eyepetozer/config/string.dart';
import 'package:xl_eyepetozer/modle/common_item.dart';
import 'package:xl_eyepetozer/utils/cache_image.dart';
import 'package:xl_eyepetozer/utils/date_util.dart';
import 'package:xl_eyepetozer/utils/history_repository.dart';
import 'package:xl_eyepetozer/utils/navigator_util.dart';
import 'package:xl_eyepetozer/viewmodle/video/video_detail_viewmodel.dart';
import 'package:xl_eyepetozer/weight/loading_state_widget.dart';
import 'package:xl_eyepetozer/weight/provider_widget.dart';
import 'package:xl_eyepetozer/weight/video/video_item_widget.dart';
import 'package:xl_eyepetozer/weight/video/video_play_widget.dart';

const VIDEO_SMALL_CARD_TYPE = 'videoSmallCard';

class VideoDetailPage extends StatefulWidget {
  final Data videoData;

  const VideoDetailPage({Key key, this.videoData}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with WidgetsBindingObserver {
  // 允许element在树周围移动(改变父节点), 而不会丢失状态
  final GlobalKey<VideoPlayWidgetState> videoKey = GlobalKey();
  Data data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.videoData == null ? arguments() : widget.videoData;
    WidgetsBinding.instance.addObserver(this);
    HistoryRepository.saveWatchHistory(data);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //AppLifecycleState当前页面的状态(是否可见)
    if (state == AppLifecycleState.paused) {
      // 页面不可见时,暂停视频
      // videoKey.currentState：树中当前具有此全局密钥的小部件的State对象
      videoKey.currentState.pause();
    } else if (state == AppLifecycleState.resumed) {
      videoKey.currentState.play();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoKey.currentState.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<VideoDetailViewModel>(
      model: VideoDetailViewModel(),
      onModelInit: (model) => model.loadVideoData(data.id),
      builder: (context, model, child) {
        return _scaffold(model);
      },
    );
  }

  Widget _scaffold(VideoDetailViewModel model) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AnnotatedRegion(
              child: Container(
                height: MediaQuery.of(context).padding.top,
                color: Colors.black,
              ),
              value: SystemUiOverlayStyle.light),
          Hero(
              tag: '${data.id}${data.time}',
              child: VideoPlayWidget(
                key: videoKey,
                url: data.playUrl,
              )),
          Expanded(
              flex: 1,
              child: LoadingStateWidget(
                viewState: model.viewState,
                retry: model.retry,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: cachedNetworkImageProvider(
                              '${data.cover.blurred}}/thumbnail/${MediaQuery.of(context).size.height}x${MediaQuery.of(context).size.width}'))),
                  child: CustomScrollView(
                    slivers: [
                      _sliverToBoxAdapter(),
                      _sliverList(model),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget _sliverToBoxAdapter() {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          //  title
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              data.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // 视频分类及上架时间
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              '#${data.category} / ${formatDateMsByYMDHM(data.author.latestReleaseTime)}',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          // 视频描述
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Text(
              data.description,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          // 视频的状态：点赞，转发，评论
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Row(
              children: <Widget>[
                _row('images/ic_like.png',
                    '${data.consumption.collectionCount}'),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: _row('images/ic_share_white.png',
                      '${data.consumption.shareCount}'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: _row('images/icon_comment.png',
                      '${data.consumption.replyCount}'),
                )
              ],
            ),
          ),
          //分割线
          Padding(
              padding: EdgeInsets.only(top: 10),
              child: Divider(height: 0.5, color: Colors.white)),
          //  视频作者介绍
          _videoAuthor(),
          Divider(height: 0.5, color: Colors.white),
        ],
      ),
    );
  }

//  点赞，转发，评论 的item
  Widget _row(String image, String text) {
    return Row(
      children: <Widget>[
        Image.asset(image, height: 22, width: 22),
        Padding(
          padding: EdgeInsets.only(left: 3),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        )
      ],
    );
  }

//  视频作者介绍
  Widget _videoAuthor() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: cacheImage(data.author.icon, height: 40, width: 40),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data.author.name,
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  data.author.description,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.all(5),
            child: Text(
              XlString.add_follow,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey),
            ),
          ),
        )
      ],
    );
  }

  Widget _sliverList(VideoDetailViewModel model) {
    return SliverList(delegate: SliverChildBuilderDelegate((context, index) {
      if (model.itemList[index].type == VIDEO_SMALL_CARD_TYPE) {
        return VideoItemWidget(
          data: model.itemList[index].data,
          callback: () {
            //  自己出栈
            Navigator.pop(context);
            // TODO:路由跳转
            toPage(VideoDetailPage(videoData: model.itemList[index].data));
          },
        );
      }
      return Padding(
        padding: EdgeInsets.all(5),
        child: Text(
          model.itemList[index].data.text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );
    }));
  }
}
