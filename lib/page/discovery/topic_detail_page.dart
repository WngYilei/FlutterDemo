import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/modle/discovery/topic_detail_model.dart';
import 'package:xl_eyepetozer/state/base_state.dart';
import 'package:xl_eyepetozer/utils/cache_image.dart';
import 'package:xl_eyepetozer/viewmodle/discovery/topic_detail_viewModel.dart';
import 'package:xl_eyepetozer/weight/app_bar.dart';
import 'package:xl_eyepetozer/weight/discovery/topic_detai_item_widget.dart';

class TopicDetailPage extends StatefulWidget {
  final int detailId;

  const TopicDetailPage({Key key, this.detailId}) : super(key: key);

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState
    extends BaseState<TopicDetailViewModel, TopicDetailPage> {
  @override
  Widget getContentChild(TopicDetailViewModel model) {
    // TODO: implement getContentChild
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(model.topicDetailModel.brief),
      body: CustomScrollView(
        slivers: <Widget>[
          _headWidget(model.topicDetailModel),
          SliverList(delegate: SliverChildBuilderDelegate((context, index) {
            return TopicDetailItemWidget(
              model: model.list[index],
            );
          }))
        ],
      ),
    );
  }

  @override
  // TODO: implement viewModel
  TopicDetailViewModel get viewModel => TopicDetailViewModel(widget.detailId);

  Widget _headWidget(TopicDetailModel topicDetailModel) {
    return SliverToBoxAdapter(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              cacheImage(
                topicDetailModel.headerImage,
                width: MediaQuery.of(context).size.width,
                height: 250,
              ),
              //  图片的文字介绍
              Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
                child: Text(
                  topicDetailModel.text,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff9a9a9a),
                  ),
                ),
              ),
              Container(
                height: 5,
                color: Colors.black12,
              ),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 230,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFF5F5F5)),
                borderRadius: BorderRadius.circular(4),
              ),
              width: MediaQuery.of(context).size.width,
              height: 50,
              alignment: Alignment.center,
              child: Text(
                topicDetailModel.brief,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
