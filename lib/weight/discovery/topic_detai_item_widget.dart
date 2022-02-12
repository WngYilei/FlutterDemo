import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/config/color.dart';
import 'package:xl_eyepetozer/config/string.dart';
import 'package:xl_eyepetozer/modle/discovery/topic_detail_model.dart';
import 'package:xl_eyepetozer/utils/cache_image.dart';
import 'package:xl_eyepetozer/utils/date_util.dart';
import 'package:xl_eyepetozer/utils/navigator_util.dart';
import 'package:xl_eyepetozer/utils/share_util.dart';
import 'package:xl_eyepetozer/weight/expand_more_text_widget.dart';

class TopicDetailItemWidget extends StatelessWidget {
  final TopicDetailItemData model;

  const TopicDetailItemWidget({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toNamed('/video_detail', model.data.content.data);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _author(),
          _description(),
          _tag(),
          _videoImage(context),
          _videoState(),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Divider(height: 0.5),
          )
        ],
      ),
    );
  }

  //作者简介
  Widget _author() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
          child: ClipOval(
              child: cacheImage(
                  model.data.header.icon == null ? '' : model.data.header.icon,
                  width: 45,
                  height: 45)),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.data.header.issuerName == null
                      ? ''
                      : model.data.header.issuerName,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '${formatDateMsByYMD(model.data.header.time)}发布：',
                      style:
                          TextStyle(color: XlColor.hitTextColor, fontSize: 12),
                    ),
                    Expanded(
                      child: Text(
                        model.data.content.data.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _description() {
    var textStyle = const TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold);
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: ExpandMoreTextWidget(
        model.data.content.data.description,
        style: TextStyle(fontSize: 14, color: XlColor.desTextColor),
        moreStyle: textStyle,
        lessStyle: textStyle,
      ),
    );
  }

  Widget _tag() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Row(children: _getTagWidgetList(model)),
    );
  }

  List<Widget> _getTagWidgetList(TopicDetailItemData itemData) {
    List<Widget> widgetList = itemData.data.content.data.tags.map((value) {
      return Container(
        margin: EdgeInsets.only(right: 5),
        alignment: Alignment.center,
        height: 20,
        padding: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: XlColor.tabBgColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          value.name,
          style: TextStyle(fontSize: 12, color: Colors.blue),
        ),
      );
    }).toList();

    return widgetList.length > 3 ? widgetList.sublist(0, 3) : widgetList;
  }

  Widget _videoImage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Hero(
              tag:
                  '${model.data.content.data.id}${model.data.content.data.time}',
              child: cacheImage(model.data.content.data.cover.feed,
                  width: MediaQuery.of(context).size.width, height: 200),
            ),
          ),
          Positioned(
            right: 8,
            bottom: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                decoration: BoxDecoration(color: Colors.black54),
                padding: EdgeInsets.all(5),
                child: Text(
                  formatDateMsByMS(model.data.content.data.duration * 1000),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _videoState() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        //  点赞
        Row(
          children: <Widget>[
            Icon(Icons.favorite_border, size: 20, color: XlColor.hitTextColor),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '${model.data.content.data.consumption.collectionCount}',
                style: TextStyle(fontSize: 12, color: XlColor.hitTextColor),
              ),
            )
          ],
        ),
      // 评论
        Row(
          children: <Widget>[
            Icon(Icons.message, size: 20, color: XlColor.hitTextColor),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '${model.data.content.data.consumption.replyCount}',
                style: TextStyle(fontSize: 12, color: XlColor.hitTextColor),
              ),
            )
          ],
        ),

        // 收藏
        Row(
          children: <Widget>[
            Icon(Icons.star_border, size: 20, color: XlColor.hitTextColor),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(XlString.collect_text,
                  style: TextStyle(fontSize: 12, color: XlColor.hitTextColor)),
            ),
          ],
        ),

        IconButton(
          icon: Icon(Icons.share, color: XlColor.hitTextColor),
          onPressed: () => share(model.data.content.data.title,
              model.data.content.data.webUrl.forWeibo),
        ),
      //
      ],
    );
  }
}
