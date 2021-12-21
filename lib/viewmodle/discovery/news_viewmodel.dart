import 'dart:io';

import 'package:xl_eyepetozer/http/Url.dart';
import 'package:xl_eyepetozer/modle/discovery/news_model.dart';
import 'package:xl_eyepetozer/viewmodle/base_list_viewmodle.dart';

class NewsViewModel extends BaseListViewModel<NewsItemModel, NewsModel> {
  @override
  NewsModel getModle(Map<String, dynamic> json) => NewsModel.fromJson(json);

  @override
  String getUrl() {
    String deviceModel = Platform.isAndroid ? "Android" : "IOS";
    return Url.newsUrl + deviceModel;
  }

  @override
  String getNextUrl(NewsModel model) {
    String deviceModel = Platform.isAndroid ? "Android" : "IOS";
    return "${model.nextPageUrl}&vc=6030000&deviceModel=$deviceModel";
  }
}
