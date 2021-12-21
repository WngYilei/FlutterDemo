import 'package:xl_eyepetozer/http/Url.dart';
import 'package:xl_eyepetozer/http/http_manager.dart';
import 'package:xl_eyepetozer/modle/discovery/topic_detail_model.dart';
import 'package:xl_eyepetozer/utils/toast_util.dart';
import 'package:xl_eyepetozer/viewmodle/base_viewmodle.dart';
import 'package:xl_eyepetozer/weight/loading_state_widget.dart';

class TopicDetailViewModel extends BaseViewModle {
  TopicDetailModel topicDetailModel = TopicDetailModel();
  List<TopicDetailItemData> list = [];
  int _id;

  TopicDetailViewModel(this._id);

  @override
  void refresh() {
    // TODO: implement refresh
    super.refresh();
    HttpManager.requestData('${Url.topicsDetailUrl}$_id').then((value) {
      topicDetailModel = TopicDetailModel.fromJson(value);
      list = topicDetailModel.itemList;
      viewState = ViewState.gone;
    }).catchError((erroe) {
      XlToast.showError(erroe.toString());
      viewState = ViewState.error;
    }).whenComplete(() => notifyListeners());
  }
}
