import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/config/color.dart';
import 'package:xl_eyepetozer/config/string.dart';

enum ViewState { loading, gone, error }

class LoadingStateWidget extends StatelessWidget {
  final ViewState viewState;
  final VoidCallback retry;
  final Widget child;

  const LoadingStateWidget(
      {Key key,
      this.viewState = ViewState.loading,
      @required this.retry,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (viewState == ViewState.loading) {
      return _loading();
    } else if (viewState == ViewState.error) {
      return _errorView();
    } else {
      return child;
    }
  }

  Widget _errorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/ic_error.png",
            width: 100,
            height: 100,
          ),
          Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(XlString.net_request_fail,
                  style: TextStyle(color: XlColor.hitTextColor, fontSize: 18))),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: OutlinedButton(
              onPressed: retry,
              child: Text(XlString.reload_again,
                  style: TextStyle(color: Colors.black87)),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.black12)),
            ),
          )
        ],
      ),
    );
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
