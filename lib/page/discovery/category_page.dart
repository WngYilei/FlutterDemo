import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:xl_eyepetozer/state/base_state.dart';
import 'package:xl_eyepetozer/utils/cache_image.dart';
import 'package:xl_eyepetozer/viewmodle/discovery/category_viewmodel.dart';

import 'category_detail_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends BaseState<CategoryViewModel, CategoryPage> {
  @override
  Widget getContentChild(CategoryViewModel model) {
    // TODO: implement getContentChild
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Color(0xfff2f2f2)),
      child: GridView.builder(
          itemCount: model.list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
          itemBuilder: (context, index) {
            return OpenContainer(
              closedBuilder: (context, action) {
                return Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: cacheImage(model.list[index].bgPicture),
                    ),
                    Center(
                      child: Text(
                        '#${model.list[index].name}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
              openBuilder: (context, action) {
                return CategoryDetailPage(categoryModel: model.list[index]);
              },
            );
          }),
    );
  }

  @override
  // TODO: implement viewModel
  CategoryViewModel get viewModel => CategoryViewModel();
}
