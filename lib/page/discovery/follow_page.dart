import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/modle/common_item.dart';
import 'package:xl_eyepetozer/state/base_list_state.dart';
import 'package:xl_eyepetozer/viewmodle/discovery/follow_viewmodel.dart';
import 'package:xl_eyepetozer/weight/discovery/follow_item_widget.dart';

class FollowPage extends StatefulWidget {
  const FollowPage({Key key}) : super(key: key);

  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState
    extends BaseListState<Item, FollowViewModel, FollowPage> {
  @override
  FollowViewModel get viewmodel => FollowViewModel();

  @override
  Widget getContentChild(FollowViewModel model) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: 0.5,
      ),
      itemCount: model.itemList.length,
      itemBuilder: (context, index) {
        return FollowItemWidget(item: model.itemList[index]);
      },
    );
  }
}
