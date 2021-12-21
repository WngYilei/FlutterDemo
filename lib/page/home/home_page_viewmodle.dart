import 'package:xl_eyepetozer/http/Url.dart';
import 'package:xl_eyepetozer/modle/common_item.dart';
import 'package:xl_eyepetozer/modle/issue_model.dart';
import 'package:xl_eyepetozer/viewmodle/base_list_viewmodle.dart';

class HomePageViewModle extends BaseListViewModel<Item, IssueEntity> {
  List<Item> bannerList = [];

  @override
  IssueEntity getModle(Map<String, dynamic> json) => IssueEntity.fromJson(json);

  @override
  String getUrl() => Url.feedUrl;

  @override
  void getData(List<Item> list) {
    bannerList = list;
    itemList.clear();
    //为Banner占位，后面要接list列表
    itemList.add(Item());
  }

  @override
  void removeUselessData(List<Item> list) {
    // 移除类型为 'banner2' 的数据
    list.removeWhere((item) {
      return item.type == 'banner2';
    });
  }

  @override
  void doExtraAfterRefresh() async {
    await loadMore();
  }
}
