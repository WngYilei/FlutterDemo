import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/modle/common_item.dart';
import 'package:xl_eyepetozer/utils/cache_image.dart';
import 'package:xl_eyepetozer/utils/date_util.dart';
import 'package:xl_eyepetozer/utils/navigator_util.dart';
import 'package:xl_eyepetozer/utils/share_util.dart';

class ListItemWidget extends StatelessWidget {
  final Item item;
  final bool showCategory;
  final bool showDivider;

  const ListItemWidget(
      {Key key, this.item, this.showCategory = true, this.showDivider = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GestureDetector(
        onTap: () {
          toNamed('/video_detail', item.data);
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Stack(
            children: <Widget>[
              _clipRRectImage(context),
              _categoryText(),
              _videoTime()
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Row(
          children: <Widget>[
            _authorHeaderImage(item),
            _videoDescription(),
            _shareButton()
          ],
        ),
      ),
      Offstage(
        offstage: showDivider,
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Divider(
            height: 0.5,
            color: Colors.red,
          ),
        ),
      )
    ]);
  }

  /// 圆角图片
  Widget _clipRRectImage(context) {
    return ClipRRect(
      child: Hero(
        tag: '${item.data.id}${item.data.time}',
        child: cacheImage(item.data.cover.feed,
            width: MediaQuery.of(context).size.width, height: 200),
      ),
      borderRadius: BorderRadius.circular(4),
    );
  }

  /// 图片左上角显示图标，视频所属分类
  Widget _categoryText() {
    return Positioned(
        left: 15,
        top: 10,
        child: Opacity(
          opacity: showCategory ? 1.0 : 0.0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(22))),
            width: 44,
            height: 44,
            alignment: AlignmentDirectional.center,
            child: Text(
              item.data.category,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ));
  }

  /// 图片右下角显示视频总时长
  Widget _videoTime() {
    return Positioned(
        right: 15,
        bottom: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: BoxDecoration(color: Colors.black54),
            padding: EdgeInsets.all(5),
            child: Text(
              formatDateMsByMS(item.data.duration * 1000),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }

  /// 作者的头像
  Widget _authorHeaderImage(Item item) {
    // ClipOval:剪切椭圆，高宽一样则为圆
    return ClipOval(
      //抗锯齿
      clipBehavior: Clip.antiAlias,
      child: cacheImage(
          item.data.author == null
              ? item.data.provider.icon
              : item.data.author.icon,
          width: 40,
          height: 40),
    );
  }

  ///视频简介
  Widget _videoDescription() {
    // Expanded:相当于Android中设置 weight 权重
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: <Widget>[
            Text(item.data.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis),
            Padding(
              padding: EdgeInsets.only(top: 2),
              child: Text(
                item.data.author == null
                    ? item.data.description
                    : item.data.author.name,
                style: TextStyle(color: Color(0xff9a9a9a), fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///分享按钮
  Widget _shareButton() {
    return IconButton(
        onPressed: () {
          share(item.data.title, item.data.playUrl);
        },
        icon: Icon(
          Icons.share,
          color: Colors.black38,
        ));
  }
}
