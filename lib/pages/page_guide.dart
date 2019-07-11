import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Guide extends StatefulWidget {
  static const routerName = '/guide';

  @override
  State<StatefulWidget> createState() {
    return GuideState();
  }
}

class GuideState extends State<Guide> {
  List<Widget> localImages = [
    Image.asset('imgs/guide_1.png'),
    Image.asset('imgs/guide_2.png'),
    Image.asset('imgs/guide_3.png'),
    Image.asset('imgs/guide_4.png'),
    Image.asset('imgs/guide_5.png'),
  ];
  GuideModel bannerModels;

  @override
  Widget build(BuildContext context) {
    bannerModels = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _getBanners(),
          Offstage(
            child: RaisedButton(
              onPressed: () {
//                Navigator.of(context).pushNamed()
              },
              color: Theme.of(context).accentColor,
              child: Text('开启爱花之旅'),
            ),
          ),
        ],
      ),
    );
  }

  /// 为后期改为网络加载引导页留口，有网络url传过来，则用网络图片，没有则用本地的。
  _getBanners() {
    if (bannerModels != null &&
        bannerModels.guideImages != null &&
        bannerModels.guideImages.length > 0) {
      localImages.clear();
      for (String s in bannerModels.guideImages) {
        localImages.add(CachedNetworkImage(imageUrl: s));
      }
    }
    return Swiper(
      itemBuilder: (context, index) {
        return localImages[index];
      },
      itemCount: localImages.length,
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          color: Colors.white,
          activeColor: Colors.white,
          activeSize: 8,
          size: 5,
        ),
      ),
      autoplay: false,
      scrollDirection: Axis.horizontal,
      onTap: (index) {},
    );
  }
}

class GuideModel {
  final List<String> guideImages;

  GuideModel({this.guideImages});
}
