import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/config/string.dart';
import 'package:xl_eyepetozer/http/Url.dart';
import 'package:xl_eyepetozer/http/http_manager.dart';
import 'package:xl_eyepetozer/modle/tab_info_model.dart';
import 'package:xl_eyepetozer/page/hot/hot_list_page.dart';
import 'package:xl_eyepetozer/utils/toast_util.dart';
import 'package:xl_eyepetozer/weight/app_bar.dart';
import 'package:xl_eyepetozer/weight/tab_bar.dart';

class HotPage extends StatefulWidget {
  const HotPage({Key key}) : super(key: key);

  @override
  _HotPageState createState() => _HotPageState();
}

class _HotPageState extends State<HotPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  PageController _pageController;
  List<TabInfoItem> _tabList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
    _pageController = PageController();
    _loadData();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(XlString.popularity_list, showBack: false),
      body: Column(
        children: <Widget>[
          tabBar(
              controller: _tabController,
              tabs: _tabList.map((TabInfoItem tabInfoItem) {
                return Tab(text: tabInfoItem.name);
              }).toList(),
              onTap: (index) {
                _pageController.animateToPage(
                    index, duration: kTabScrollDuration, curve: Curves.ease);
              }
          ),
          Expanded(child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              _tabController.index = index;
            },
            children: _tabList.map((TabInfoItem tabInfoItem) {
              return HotListPage(apiUrl: tabInfoItem.apiUrl);
            }).toList(),
          ))

        ],
      ),
    );
  }

  void _loadData() {
    HttpManager.getData(Url.rankUrl, success: (result) {
      TabInfoModel tabInfoModel = TabInfoModel.fromJson(result);
      setState(() {
        _tabList = tabInfoModel.tabInfo.tabList;
        _tabController = TabController(length: _tabList.length, vsync: this);
      });
    }, fail: (e) {
      XlToast.showError(e.toString());
    });
  }
}
