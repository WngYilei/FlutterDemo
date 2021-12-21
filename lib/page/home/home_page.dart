import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/config/string.dart';
import 'package:xl_eyepetozer/page/home/search_page.dart';
import 'package:xl_eyepetozer/weight/app_bar.dart';
import 'home_body_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(XlString.home,
          showBack: false,
          actions: <Widget>[
            _searchIcon()
          ]),
      body: HomeBodyPage(),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _searchIcon() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: OpenContainer(
        closedElevation: 0.0,
        closedBuilder: (context, acttion) {
          return Icon(Icons.search, color: Colors.black87);
        },
        openBuilder: (context, action) {
          return SearchPage();
        },
      ),
    );
  }
}