import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:xl_eyepetozer/config/color.dart';
import 'package:xl_eyepetozer/modle/discovery/news_model.dart';
import 'package:xl_eyepetozer/state/base_list_state.dart';
import 'package:xl_eyepetozer/utils/cache_image.dart';
import 'package:xl_eyepetozer/utils/navigator_util.dart';
import 'package:xl_eyepetozer/viewmodle/discovery/news_viewmodel.dart';

const TEXT_CARD_TYPE = "textCard";
const INFORMATION_CARD_TYPE = "informationCard";

class NewsPage extends StatefulWidget {
  const NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState
    extends BaseListState<NewsItemModel, NewsViewModel, NewsPage> {
  @override
  Widget getContentChild(NewsViewModel model) {
    return ListView.builder(
      itemCount: model.itemList.length,
      itemBuilder: (context, index) {
        if (model.itemList[index].type == TEXT_CARD_TYPE) {
          return Container(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Text(
              model.itemList[index].data.text,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff3f3f3f),
              ),
            ),
          );
        } else {
          return _itemContent(model.itemList[index]);
        }
      },
    );
  }

  @override
  // TODO: implement viewmodel
  NewsViewModel get viewmodel => NewsViewModel();

  Widget _itemContent(item) {
    return GestureDetector(
      onTap: () {
        String url = Uri.decodeComponent(
            item.data.actionUrl.substring(item.data.actionUrl.indexOf("url")));
        // 去掉前面的 'url='
        url = url.substring(4, url.length);
        // toPage(WebPage(url: url));
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        // PhysicalModel：将其子控件裁剪为一个形状，可以设置阴影值及颜色
        child: PhysicalModel(
          color: Color(0xFFEDEDED),
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: cacheImage(
                      item.data.backgroundImage,
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      // 充满：可能会改变图片的宽高比
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _getTitleList(item.data.titleList),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  List<Widget> _getTitleList(List<String> titleList) {
    return titleList.map((title) {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Text(
          title,
          style: TextStyle(color: XlColor.desTextColor, fontSize: 12),
          maxLines: 3,
          // 超出的部分，省略号处理
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList();
  }
}
