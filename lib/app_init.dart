import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:xl_eyepetozer/utils/cache_manager.dart';
import 'http/Url.dart';

class AppInit {
  AppInit._();

  static Future<void> init() async {
    await CacheManager.preInit();
    Url.baseUrl = 'http://baobab.kaiyanapp.com/api/';
    Future.delayed(Duration(milliseconds: 2000), () {
      FlutterSplashScreen.hide();
    });
  }
}
