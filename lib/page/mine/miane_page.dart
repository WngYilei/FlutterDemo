import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xl_eyepetozer/utils/cache_manager.dart';
import 'package:xl_eyepetozer/utils/navigator_util.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  File _imageFile;
  final picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAvatarPath();
  }

  _getAvatarPath() {
    var userAvatarPath =
        CacheManager.getInstance().get<String>("user_avatar_path");
    if (userAvatarPath != null && userAvatarPath.isNotEmpty) {
      setState(() {
        _imageFile = File(userAvatarPath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          padding: EdgeInsets.only(top: 20),
          children: <Widget>[
            //  头像
            Stack(
              alignment: Alignment.center,
              children: [
                // 高斯模糊背景
                //... 散布运算符，将列表的所有元素插入另一个列表
                ..._headBackground(),
                _headContent(),
              ],
            ),
            //  收藏，评论
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _imageAndText('images/icon_like_grey.png', '收藏'),
                  Container(
                    width: 0.5,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                  _imageAndText('images/icon_comment_grey.png', '评论'),
                ],
              ),
            ),
            //  分割线
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                height: 0.5,
                decoration: BoxDecoration(color: Colors.grey),
              ),
            ),
            // 几个设置的widget
            //... 散布运算符，将列表的所有元素插入另一个列表
            ..._listSetting(),
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  List<Widget> _headBackground() {
    return [
      Positioned.fill(
          child: Image(
        image: _imageFile == null
            ? AssetImage('images/ic_img_avatar.png')
            : FileImage(_imageFile),
        fit: BoxFit.cover,
      )),
      Positioned.fill(
          child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          color: Colors.white.withOpacity(0.0),
        ),
      ))
    ];
  }

  Widget _headContent() {
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.only(top: 45),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 44,
              backgroundImage: _imageFile == null
                  ? AssetImage('images/ic_img_avatar.png')
                  : FileImage(_imageFile),
            ),
          ),
          onTap: () {
            _showSelectPhotoDialog(context);
          },
        ),
      ],
    );
  }

  void _showSelectPhotoDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _bottomWidget("拍照", () {
                back();
                getImage(ImageSource.camera);
              }),
              _bottomWidget("相册", () {
                back();
                getImage(ImageSource.gallery);
              }),
              _bottomWidget("取消", () {
                back();
              }),
            ],
          );
        });
  }

  Widget _bottomWidget(String text, VoidCallback voidCallback) {
    return ListTile(
        title: Text(text, textAlign: TextAlign.center), onTap: voidCallback);
  }

  void getImage(ImageSource source) async {
    var imageFile = await picker.pickImage(source: source);
    setState(() {
      _imageFile = File(imageFile.path);
    });
    // 将图片的路径缓存起来
    CacheManager.getInstance().set("user_avatar_path", _imageFile.path);
  }

  Widget _imageAndText(String image, String text) {
    return Row(
      children: <Widget>[
        Image.asset(
          image,
          width: 20,
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        )
      ],
    );
  }

  _listSetting() {
    return [
      _setting("我的消息"),
      _setting("我的记录"),
      _setting("我的缓存"),
      _setting("观看记录", callback: () {
        // toPage(WatchHistoryPage());
      })
    ];
  }

  Widget _setting(String text, {VoidCallback callback}) {
    return InkWell(
        onTap: callback,
        child: Row(
          children: [
            Container(
              // alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 30, left: 30),
              child: Text(
                text,
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
            //隔开
            Expanded(
              child: Text(''), // 中间用Expanded控件
            ),
            IconButton(
              icon: Icon(
                Icons.chevron_right_outlined,
                color: Colors.black38,
              ),
              padding: EdgeInsets.only(top: 30, right: 20),
            )
          ],
        ));
  }
}
