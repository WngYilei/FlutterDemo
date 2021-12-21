import 'package:xl_eyepetozer/http/Url.dart';
import 'package:xl_eyepetozer/modle/common_item.dart';
import 'package:xl_eyepetozer/viewmodle/base_list_viewmodle.dart';

class CategoryDetailViewModel extends BaseListViewModel<Item, Issue> {
  int categoryId;

  CategoryDetailViewModel(this.categoryId);

  @override
  Issue getModle(Map<String, dynamic> json) => Issue.fromJson(json);

  @override
  String getUrl() =>
      Url.categoryVideoUrl +
      "id=$categoryId&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=Android";

  @override
  String getNextUrl(Issue modle) {
    return modle.nextPageUrl +
        "&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=Android";
  }
}
