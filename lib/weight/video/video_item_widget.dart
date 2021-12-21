import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/modle/common_item.dart';
import 'package:xl_eyepetozer/utils/cache_image.dart';
import 'package:xl_eyepetozer/utils/date_util.dart';

class VideoItemWidget extends StatelessWidget {
  final Data data;
  final VoidCallback callback;

  final bool openHero;

  final Color titleColor;
  final Color categoryColor;

  const VideoItemWidget(
      {Key key,
      this.data,
      this.callback,
      this.openHero = false,
      this.titleColor = Colors.white,
      this.categoryColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Row(
          children: <Widget>[
            //左边的视频图片
            _videoImage(),
            //右边的视频文字
            _videoText(),
          ],
        ),
      ),
    );
  }

  /// 左边图片显示设置
  Widget _videoImage() {
    // 类似 FrameLayout
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: _coverWidget(),
        ),
        //视频播放时长
        Positioned(
            right: 5,
            bottom: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                decoration: BoxDecoration(color: Colors.black54),
                padding: EdgeInsets.all(3),
                child: Text(
                  formatDateMsByMS(data.duration * 1000),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ))
      ],
    );
  }

  Widget _coverWidget() {
    if (openHero) {
      return Hero(
          tag: '${data.id}${data.title}',
          child: cacheImage(data.cover.detail, width: 135, height: 80));
    } else {
      return cacheImage(data.cover.detail, width: 135, height: 80);
    }
  }

  Widget _videoText() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              data.title,
              style: TextStyle(
                  color: titleColor, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                '#${data.category} / ${data.author?.name}',
                style: TextStyle(color: categoryColor, fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
