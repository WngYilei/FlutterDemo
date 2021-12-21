import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:xl_eyepetozer/utils/cache_image.dart';
import 'package:xl_eyepetozer/utils/navigator_util.dart';
import 'package:xl_eyepetozer/viewmodle/discovery/recommend_photo_viewModel.dart';
import 'package:xl_eyepetozer/weight/provider_widget.dart';

class RecommendPhotoPage extends StatefulWidget {
  final List<String> galleryItems;

  const RecommendPhotoPage({Key key, this.galleryItems}) : super(key: key);

  @override
  _RecommendPhotoPageState createState() => _RecommendPhotoPageState();
}

class _RecommendPhotoPageState extends State<RecommendPhotoPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: ProviderWidget<RecommendPhotoViewModel>(
            model: RecommendPhotoViewModel(),
            builder: (context, model, index) {
              return Stack(
                children: <Widget>[
                  //  图片处理
                  _photoViewGallery(model),
                  //  向下按钮
                  Positioned(
                    left: 10,
                    // 加上导航栏的高度
                    top: MediaQuery.of(context).padding.top + 10,
                    child: GestureDetector(
                      onTap: () => back(),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(12)),
                        width: 24,
                        height: 24,
                        child: Icon(Icons.keyboard_arrow_down, size: 20),
                      ),
                    ),
                  ),
                  //  当前照片是总张数中的第几张
                  Align(
                    alignment: Alignment.topCenter,
                    child: Offstage(
                      offstage: widget.galleryItems.length == 1,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top + 15),
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          '${model.currentIndex}/${widget.galleryItems.length}',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _photoViewGallery(RecommendPhotoViewModel model) {
    return PhotoViewGallery.builder(
      itemCount: widget.galleryItems.length,
      enableRotation: true,
      backgroundDecoration: BoxDecoration(color: Colors.black),
      onPageChanged: (index) => model.changeIndex(index),
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: cachedNetworkImageProvider(widget.galleryItems[index]),
          initialScale: PhotoViewComputedScale.contained * 1,
          minScale: PhotoViewComputedScale.contained * 1,
        );
      },
      loadingBuilder: (context, event) {
        return Center(
          child: Container(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
