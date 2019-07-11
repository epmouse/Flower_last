import 'package:flower_last/widgets/CountDownWidget.dart';
import 'package:flutter/material.dart';

typedef OnHideCallBack = void Function();

class Splash extends StatefulWidget {
  final OnHideCallBack onHideCallback;
  final imgUrl;

  Splash({this.onHideCallback, this.imgUrl});

  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<Splash> {
  Widget _splashImg = Image.asset(
    //经测试，使用网络图片，加载会有延时，不适合做splash页，可以考虑把网络图片下载到本地，然后再加载。
    'imgs/guide_1.png',
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _splashImg,
          Align(
            alignment: Alignment(0.9, -0.8),
            child: CountDownWidget(onCountDownFinishedCallback: () {
              widget.onHideCallback();
            }),
          )
        ],
      ),
    );
  }
}
