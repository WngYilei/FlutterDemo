import 'package:animations/animations.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/modle/discovery/topic_model.dart';
import 'package:xl_eyepetozer/page/discovery/topic_detail_page.dart';
import 'package:xl_eyepetozer/state/base_list_state.dart';
import 'package:xl_eyepetozer/utils/cache_image.dart';
import 'package:xl_eyepetozer/viewmodle/discovery/topic_viewmodel.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({Key key}) : super(key: key);

  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState
    extends BaseListState<TopicItemModel, TopicViewModel, TopicPage> {
  @override
  Widget getContentChild(TopicViewModel model) {
    return ListView.separated(itemBuilder: (context, index) {
      return OpenContainer(
        closedBuilder: (context, action) {
          return Padding(padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: cacheImage(
                  model.itemList[index].data.image,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 200
              ),
            ),
          );
        },
        openBuilder: (context, action) {
          return TopicDetailPage(detailId: model.itemList[index].data.id);
        },
      );
    },
        separatorBuilder: (context, index) {
          return Divider(height: 0.5);
        },
        itemCount: model.itemList.length);
  }

  @override
  // TODO: implement viewmodel
  TopicViewModel get viewmodel => TopicViewModel();
}
