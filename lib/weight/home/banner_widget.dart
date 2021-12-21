import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xl_eyepetozer/page/home/home_page_viewmodle.dart';
import 'package:xl_eyepetozer/utils/cache_image.dart';
import 'package:xl_eyepetozer/utils/navigator_util.dart';

class BannerWidget extends StatelessWidget {
  final HomePageViewModle modle;

  const BannerWidget({Key key, this.modle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: cachedNetworkImageProvider(
                          modle.bannerList[index].data.cover.feed),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width - 30,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 10, 10),
                decoration: BoxDecoration(color: Colors.black12),
                child: Text(
                  modle.bannerList[index].data.title,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            )
          ],
        );
      },
      onTap: (index) {
        toNamed("/detail", modle.bannerList[index].data);
      },
      itemCount: modle.bannerList.length ?? 0,
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          builder: DotSwiperPaginationBuilder(
              size: 8,
              activeSize: 8,
              activeColor: Colors.white,
              color: Colors.white24)),
    );
  }
}
