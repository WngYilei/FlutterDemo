import 'package:xl_eyepetozer/modle/common_item.dart';
import 'package:xl_eyepetozer/viewmodle/base_list_viewmodle.dart';

class HotListViewModel extends BaseListViewModel<Item, Issue> {
  String apiUrl;

  HotListViewModel(this.apiUrl);

  @override
  Issue getModle(Map<String, dynamic> json) => Issue.fromJson(json);

  @override
  String getUrl() => apiUrl;
}
