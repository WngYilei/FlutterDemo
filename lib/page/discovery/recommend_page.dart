import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:xl_eyepetozer/modle/discovery/recommend_model.dart';
import 'package:xl_eyepetozer/weight/discovery/recommend_item_widget.dart';
import 'package:xl_eyepetozer/weight/discovery/recommend_loading.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({Key key}) : super(key: key);

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  RecommendLoading _recommendLoading = RecommendLoading();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _recommendLoading.dispose();
  }

  Future<void> _refresh() async {
    return _recommendLoading.refresh().whenComplete(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final int crossAxisCount = max(constraints.maxWidth ~/ (MediaQuery.of(context).size.width / 2.0), 2);
            return LoadingMoreList<RecommendItem>(ListConfig(
              // 扩展 WaterfallFlow(瀑布流) 等列表--默认flutter没有实现瀑布流
              extendedListDelegate:
                  SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, item, index) {
                return RecommendItemWidget(item: item);
              },
              sourceList: _recommendLoading,
              padding: const EdgeInsets.all(5.0),
              lastChildLayoutType: LastChildLayoutType.foot,
            ));
          },
        ),
      ),
    );
  }
}
