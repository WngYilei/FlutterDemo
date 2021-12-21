import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xl_eyepetozer/modle/paging_modle.dart';
import 'package:xl_eyepetozer/viewmodle/base_list_viewmodle.dart';
import 'package:xl_eyepetozer/weight/loading_state_widget.dart';
import 'package:xl_eyepetozer/weight/provider_widget.dart';

abstract class BaseListState<L, M extends BaseListViewModel<L, PagingModel<L>>, T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin {
  //真是获取数据的仓库
  M get viewmodel;

  //真是的分页组件
  Widget getContentChild(M model);

  bool enablePullDown = true;
  bool enablePullUp = true;

  void init() {}

  @override
  Widget build(BuildContext context) {
    super.build(context);
    init();
    return ProviderWidget<M>(
        model: viewmodel,
        onModelInit: (modle) => modle.refresh(),
        builder: (context, model, child) {
          return LoadingStateWidget(
              viewState: model.viewState,
              retry: model.retry,
              child: Container(
                color: Colors.white,
                child: SmartRefresher(
                  controller: model.refreshController,
                  onRefresh: model.refresh,
                  onLoading: model.loadMore,
                  enablePullDown: enablePullDown,
                  enablePullUp: enablePullUp,
                  child: getContentChild(model),
                ),
              ));
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
