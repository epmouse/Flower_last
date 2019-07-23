import 'package:flower_last/pages/page_main_docker.dart';
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

  var _hideButton = true;

  @override
  Widget build(BuildContext context) {
    bannerModels = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _getBanners(),
          Offstage(
            offstage: _hideButton,
            child: Align(
              alignment: Alignment(0, 0.85),
              child: RaisedButton(
                onPressed: () {
                Navigator.of(context).popAndPushNamed(MainNavPage.routerName);
                },
                color: Colors.white,
                child: Text(
                  '开启爱花之旅',
                  style: TextStyle(color: Colors.red[200]),
                ),
                elevation: 1,
                shape: ContinuousRectangleBorder(
                  side: BorderSide(color: Colors.red[200], width: 0.3),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
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
    return Container(
      child: Swiper(
        itemBuilder: (context, index) {
          return localImages[index];
        },
        itemCount: localImages.length,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey,
            activeColor: Colors.grey,
            activeSize: 8,
            size: 5,
          ),
        ),
        autoplay: false,
        scrollDirection: Axis.horizontal,
        onTap: (index) {},
        onIndexChanged: (index) {
          setState(() {
            _hideButton = index != (localImages.length - 1);
          });
        },
      ),
    );
  }
}

class GuideModel {
  final List<String> guideImages;

  GuideModel({this.guideImages});
}
