import 'dart:convert';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xl_eyepetozer/http/http_manager.dart';
import 'package:xl_eyepetozer/modle/paging_modle.dart';
import 'package:xl_eyepetozer/utils/toast_util.dart';
import 'package:xl_eyepetozer/viewmodle/base_change_notifier.dart';
import 'package:xl_eyepetozer/weight/loading_state_widget.dart';

abstract class BaseListViewModel<T, M extends PagingModel<T>>
    extends BaseChangeNotifier {
  List<T> itemList = [];

  String nextPageUrl;

  RefreshController refreshController =
      new RefreshController(initialRefresh: false);

  //请求数据地址
  String getUrl();

  //请求返回的真实的数据模型
  M getModle(Map<String, dynamic> json);

  //获取数据
  void getData(List<T> list) {
    this.itemList = list;
  }

//  移除无用数据
  void removeUselessData(List<T> list) {}

  //下拉刷新后的额外操作
  void doExtraAfterRefresh() {}

  //上拉加载更多请求地址
  String getNextUrl(M modle) {
    return modle.nextPageUrl;
  }

  //下拉刷新
  void refresh() {
    HttpManager.getData(getUrl(), success: (json) {
      M model = getModle(json);
      removeUselessData(model.itemList);
      getData(model.itemList);
      viewState = ViewState.gone;
      //  下一页数据处理
      nextPageUrl = getNextUrl(model);
      refreshController.refreshCompleted();
      refreshController.footerMode.value = LoadStatus.canLoading;
      doExtraAfterRefresh();
    }, fail: (e) {
      XlToast.showError(e.toString());
      refreshController.refreshFailed();
      viewState = ViewState.error;
    }, complete: () {
      notifyListeners();
    });
  }

  Future<void> loadMore() async {
    if (nextPageUrl == null) {
      refreshController.loadNoData();
      return;
    }
    HttpManager.getData(nextPageUrl, success: (json) {
      M modle = getModle(json);
      removeUselessData(modle.itemList);
      itemList.addAll(modle.itemList);
      nextPageUrl = getNextUrl(modle);
      refreshController.loadComplete();
      notifyListeners();
    }, fail: (e) {
      XlToast.showError(e.toString());
      refreshController.loadFailed();
    }, complete: () {
      notifyListeners();
    });
  }

  retry() {
    viewState = ViewState.loading;
    notifyListeners();
    refresh();
  }
}
