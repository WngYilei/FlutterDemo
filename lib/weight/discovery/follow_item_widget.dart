import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/config/string.dart';
import 'package:xl_eyepetozer/modle/common_item.dart';
import 'package:xl_eyepetozer/utils/cache_image.dart';
import 'package:xl_eyepetozer/utils/date_util.dart';
import 'package:xl_eyepetozer/utils/navigator_util.dart';

class FollowItemWidget extends StatelessWidget {
  final Item item;

  const FollowItemWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          _videoAuthor(),
          Container(
            height: 230,
            child: ListView.builder(
                itemCount: item.data.itemList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return _inkWell(
                    item: item.data.itemList[index],
                    last: index == item.data.itemList.length - 1,
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _inkWell({Item item, bool last}) {
    return InkWell(
      onTap: () => toNamed('/detail', item.data),
      child: Container(
        padding: EdgeInsets.only(left: 15, right: last ? 15 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// 视频上线时间
            Container(
              child: Text(
                formatDateMsByYMDHM(item.data.author.latestReleaseTime),
                style: TextStyle(fontSize: 12, color: Colors.black26),
              ),
            ),

            /// 视频名称
            Container(
              width: 300,
              padding: EdgeInsets.only(top: 3, bottom: 3),
              child: Text(
                item.data.title,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Hero(
                    tag: '${item.data.id}${item.data.time}',
                    child: cacheImage(item.data.cover.feed,
                        width: 300, height: 180),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(color: Colors.white54),
                      alignment: Alignment.center,
                      child: Text(
                        item.data.category,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _videoAuthor() {
    return Container(
      // 设置左上右下间距
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        children: <Widget>[
          ClipOval(
            child: cacheImage(item.data.header.icon, width: 40, height: 40),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.data.header.title,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      item.data.header.description,
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(color: Color(0xFFF4F4F4)),
              child: Text(
                XlString.add_follow,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
