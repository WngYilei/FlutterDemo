import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/modle/common_item.dart';
import 'package:xl_eyepetozer/modle/discovery/category_model.dart';
import 'package:xl_eyepetozer/state/base_list_state.dart';
import 'package:xl_eyepetozer/utils/cache_image.dart';
import 'package:xl_eyepetozer/utils/navigator_util.dart';
import 'package:xl_eyepetozer/viewmodle/base_list_viewmodle.dart';
import 'package:xl_eyepetozer/viewmodle/discovery/category_detail_viewModel.dart';
import 'package:xl_eyepetozer/weight/list_item_widget.dart';

class CategoryDetailPage extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryDetailPage({Key key, this.categoryModel}) : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState
    extends BaseListState<Item, CategoryDetailViewModel, CategoryDetailPage> {
  @override
  Widget getContentChild(CategoryDetailViewModel model) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: GestureDetector(
            onTap: () => back(),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          //  阴影
          elevation: 0,
          //  亮度
          brightness: Brightness.light,
          //  背景色
          backgroundColor: Colors.white,
          //  展开的区域
          expandedHeight: 200.0,
          // 设置为true时，当SliverAppBar内容滑出屏幕时，将始终渲染一个固定在顶部的收起状态
          pinned: true,
          //  折叠区域
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              changeExpendStatus(
                  (MediaQuery.of(context).padding.top.toInt() + 56),
                  constraints.biggest.height.toInt());
              return FlexibleSpaceBar(
                title: Text(
                  widget.categoryModel.name,
                  style:
                      TextStyle(color: isExpend ? Colors.white : Colors.black),
                ),
                centerTitle: false,
                background: cacheImage(widget.categoryModel.headerImage),
              );
            },
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ListItemWidget(
              item: model.itemList[index],
              showCategory: false,
              showDivider: false,
            );
          }),
        ),
      ],
    );
  }

  // 判断是否展开，从而改变字体颜色
  bool isExpend = true;

  void changeExpendStatus(int statusBarHeight, int offset) {
    if (offset > statusBarHeight && offset < 250) {
      if (!isExpend) {
        isExpend = true;
      }
    } else {
      if (isExpend) {
        isExpend = false;
      }
    }
  }

  @override
  // TODO: implement viewmodel
  CategoryDetailViewModel get viewmodel =>
      CategoryDetailViewModel(widget.categoryModel.id);
}
