import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xl_eyepetozer/app_init.dart';
import 'package:xl_eyepetozer/page/home/home_page.dart';
import 'package:xl_eyepetozer/page/video/video_detail_page.dart';
import 'package:xl_eyepetozer/tab_navigation.dart';

import 'page/discovery/discovery_page.dart';

void main() {
  runApp(MyApp());
  //Flutter沉浸式状态栏，Platform.isAndroid 判断是否是Android手机
  if (Platform.isAndroid) {
    // setSystemUIOverlayStyle:用来设置状态栏顶部和底部样式
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AppInit.init(),
        builder: (BuildContext contexgt, AsyncSnapshot<void> snapshot) {
          StatefulWidget widget;
          if (snapshot.connectionState == ConnectionState.done) {
            widget = TabNavigation();
          } else {
            widget = Scaffold(
              body: Center(
                // 圈
                child: CircularProgressIndicator(),
              ),
            );
          }
          return GetMaterialAppWidget(child: widget);
        });
  }
}

class GetMaterialAppWidget extends StatefulWidget {
  final Widget child;

  GetMaterialAppWidget({Key key, this.child}) : super(key: key);

  @override
  _GetMaterialAppWidgetState createState() => _GetMaterialAppWidgetState();
}

class _GetMaterialAppWidgetState extends State<GetMaterialAppWidget> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "开眼",
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => widget.child),
        GetPage(name: '/video_detail', page: () => VideoDetailPage()),
      ],
        routes: <String, WidgetBuilder>{
          'home': (BuildContext context) => HomePage(),
          'DiscoveryPage': (BuildContext context) => DiscoveryPage(),
        },
    );
  }
}
