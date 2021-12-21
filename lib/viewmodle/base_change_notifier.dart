import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/weight/loading_state_widget.dart';

class BaseChangeNotifier with ChangeNotifier {
  ViewState viewState = ViewState.loading;
  bool _dispose = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dispose = true;
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
      // TODO: implement notifyListeners
      super.notifyListeners();
    }
  }
}
