import 'package:xl_eyepetozer/http/Url.dart';
import 'package:xl_eyepetozer/modle/discovery/topic_model.dart';
import 'package:xl_eyepetozer/viewmodle/base_list_viewmodle.dart';

class TopicViewModel extends BaseListViewModel<TopicItemModel, TopicModel> {
  @override
  TopicModel getModle(Map<String, dynamic> json) => TopicModel.fromJson(json);

  @override
  String getUrl() => Url.topicsUrl;
}
