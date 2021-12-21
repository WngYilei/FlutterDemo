import 'dart:convert';

import 'package:loading_more_list/loading_more_list.dart';
import 'package:xl_eyepetozer/http/Url.dart';
import 'package:xl_eyepetozer/http/http_manager.dart';
import 'package:xl_eyepetozer/modle/discovery/recommend_model.dart';
import 'package:xl_eyepetozer/utils/toast_util.dart';

class RecommendLoading extends LoadingMoreBase<RecommendItem> {
  String nextPageUrl;
  bool _more = true;
  bool forceRefresh = false;
  Utf8Decoder utf8decoder = Utf8Decoder();

  @override
  bool get hasMore => super.hasMore;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _more = true;
    forceRefresh = !notifyStateChanged;
    final bool result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    String url = '';
    if (isloadMoreAction) {
      url = nextPageUrl;
    } else {
      url = Url.communityUrl;
    }
    return HttpManager.requestData(url, headers: Url.httpHeader).then((value) {
      RecommendModel recommendModel = RecommendModel.fromJson(value);
      recommendModel.itemList.removeWhere((item) {
        return item.type == 'horizontalScrollCard';
      });
      if (!isloadMoreAction) {
        clear();
      }
      addAll(recommendModel.itemList);
      nextPageUrl = recommendModel.nextPageUrl;
      _more = nextPageUrl != null;
      return true;
    }).catchError((e) {
      XlToast.showError(e.toString());
      return false;
    });
  }
}
