import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/config/string.dart';
import 'package:xl_eyepetozer/page/discovery/follow_page.dart';
import 'package:xl_eyepetozer/page/discovery/recommend_page.dart';
import 'package:xl_eyepetozer/page/discovery/topic_page.dart';
import 'package:xl_eyepetozer/weight/app_bar.dart';
import 'package:xl_eyepetozer/weight/tab_bar.dart';

import 'category_page.dart';
import 'news_page.dart';

const TAB_LABEL = ['关注', '分类', '专题', '资讯', '推荐'];

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({Key key}) : super(key: key);

  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: TAB_LABEL.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        XlString.discovery,
        showBack: false,
        bottom: tabBar(
          controller: _tabController,
          tabs: TAB_LABEL.map((e) => Tab(text: e)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          FollowPage(),
          CategoryPage(),
          TopicPage(),
          NewsPage(),
          RecommendPage(),
        ],
      ),
    );
  }
}
