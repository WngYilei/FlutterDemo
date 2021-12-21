import 'package:xl_eyepetozer/http/Url.dart';
import 'package:xl_eyepetozer/http/http_manager.dart';
import 'package:xl_eyepetozer/modle/common_item.dart';
import 'package:xl_eyepetozer/utils/toast_util.dart';
import 'package:xl_eyepetozer/viewmodle/base_change_notifier.dart';
import 'package:xl_eyepetozer/weight/loading_state_widget.dart';

class VideoDetailViewModel extends BaseChangeNotifier {
  List<Item> itemList = [];
  int _videoId;

  void loadVideoData(int id) {
    _videoId = id;
    HttpManager.requestData('${Url.videoRelatedUrl}$id').then((res) {
      Issue issue = Issue.fromJson(res);
      itemList = issue.itemList;
      viewState = ViewState.gone;
    }).catchError((e) {
      XlToast.showError(e.toString());
      viewState = ViewState.error;
    }).whenComplete(() => notifyListeners());
  }

  void retry() {
    viewState = ViewState.loading;
    notifyListeners();
    loadVideoData(_videoId);
  }
}
