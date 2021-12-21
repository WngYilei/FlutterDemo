import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/modle/common_item.dart';
import 'package:xl_eyepetozer/state/base_list_state.dart';
import 'package:xl_eyepetozer/viewmodle/hot/hot_list_viewmodel.dart';
import 'package:xl_eyepetozer/weight/list_item_widget.dart';

class HotListPage extends StatefulWidget {
  final String apiUrl;

  const HotListPage({Key key, this.apiUrl}) : super(key: key);

  @override
  _HotListPageState createState() => _HotListPageState();
}

class _HotListPageState
    extends BaseListState<Item, HotListViewModel, HotListPage> {
  void init() {
    enablePullUp = false;
  }

  @override
  Widget getContentChild(HotListViewModel model) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListItemWidget(item: model.itemList[index]);
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Divider(height: 0.5),
          );
        },
        itemCount: model.itemList.length);
  }

  @override
  // TODO: implement viewmodel
  HotListViewModel get viewmodel => HotListViewModel(widget.apiUrl);
}
