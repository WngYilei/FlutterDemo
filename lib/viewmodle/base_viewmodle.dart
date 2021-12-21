import 'package:xl_eyepetozer/viewmodle/base_change_notifier.dart';
import 'package:xl_eyepetozer/weight/loading_state_widget.dart';

abstract class BaseViewModle extends BaseChangeNotifier {
  void refresh() {}

  void loadMore() {}

  void retry() {
    viewState = ViewState.loading;
    notifyListeners();
    refresh();
  }
}
