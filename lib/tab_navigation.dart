import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/config/string.dart';
import 'package:xl_eyepetozer/page/discovery/discovery_page.dart';
import 'package:xl_eyepetozer/page/home/home_page.dart';
import 'package:xl_eyepetozer/page/hot/hot_page.dart';
import 'package:xl_eyepetozer/page/mine/miane_page.dart';
import 'package:xl_eyepetozer/utils/toast_util.dart';
import 'package:xl_eyepetozer/viewmodle/tab_navigation_viewmodel.dart';
import 'package:xl_eyepetozer/weight/provider_widget.dart';

class TabNavigation extends StatefulWidget {
  const TabNavigation({Key key}) : super(key: key);

  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  DateTime lastTime;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePage(),
            DiscoveryPage(),
            HotPage(),
            MinePage(),
          ],
        ),
        bottomNavigationBar: ProviderWidget<TabNavigationViewModel>(
            model: TabNavigationViewModel(),
            builder: (context, modle, child) {
              return BottomNavigationBar(
                currentIndex: modle.currentIndex,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Color(0xff000000),
                unselectedItemColor: Color(0xff9a9a9a),
                items: _item(),
                onTap: (index) {
                  if (modle.currentIndex != index) {
                    _pageController.jumpToPage(index);
                    modle.changeBottomTabIndex(index);
                  }
                },
              );
            }),
      ),
    );
  }

  List<BottomNavigationBarItem> _item() {
    return [
      _bottomItem(XlString.home, "images/ic_home_normal.png",
          "images/ic_home_selected.png"),
      _bottomItem(XlString.discovery, 'images/ic_discovery_normal.png',
          'images/ic_discovery_selected.png'),
      _bottomItem(XlString.hot, 'images/ic_hot_normal.png',
          'images/ic_hot_selected.png'),
      _bottomItem(XlString.mine, 'images/ic_mine_normal.png',
          'images/ic_mine_selected.png'),
    ];
  }

  _bottomItem(String title, String normalIcon, String selectIcon) {
    return BottomNavigationBarItem(
        icon: Image.asset(normalIcon, width: 24, height: 24),
        activeIcon: Image.asset(
          selectIcon,
          width: 24,
          height: 25,
        ),
        label: title);
  }

  Future<bool> _onWillPop() async {
    if (lastTime == null ||
        DateTime.now().difference(lastTime) > Duration(seconds: 2)) {
      lastTime = DateTime.now();
      XlToast.showTip(XlString.exit_tip);
      return false;
    } else {
      return true;
    }
  }
}
