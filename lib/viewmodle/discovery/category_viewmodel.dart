import 'package:xl_eyepetozer/http/Url.dart';
import 'package:xl_eyepetozer/http/http_manager.dart';
import 'package:xl_eyepetozer/modle/discovery/category_model.dart';
import 'package:xl_eyepetozer/modle/paging_modle.dart';
import 'package:xl_eyepetozer/utils/toast_util.dart';
import 'package:xl_eyepetozer/viewmodle/base_list_viewmodle.dart';
import 'package:xl_eyepetozer/viewmodle/base_viewmodle.dart';
import 'package:xl_eyepetozer/weight/loading_state_widget.dart';

class CategoryViewModel extends BaseViewModle {
  List<CategoryModel> list = [];

  @override
  void refresh() {
    // TODO: implement refresh
    super.refresh();
    HttpManager.getData(Url.categoryUrl, success: (json) {
      list =
          (json as List).map((model) => CategoryModel.fromJson(model)).toList();
      viewState = ViewState.gone;
    }, fail: (e) {
      XlToast.showError(e.toString());
      viewState = ViewState.error;
    }, complete: () {
      notifyListeners();
    });
  }
}
