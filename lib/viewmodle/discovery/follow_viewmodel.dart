import 'package:xl_eyepetozer/http/Url.dart';
import 'package:xl_eyepetozer/modle/common_item.dart';
import 'package:xl_eyepetozer/viewmodle/base_list_viewmodle.dart';

class FollowViewModel extends BaseListViewModel<Item, Issue> {
  @override
  Issue getModle(Map<String, dynamic> json) => Issue.fromJson(json);

  @override
  String getUrl() => Url.followUrl;
}
