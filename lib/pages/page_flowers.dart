import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flower_last/utils/DeviceInfoUtils.dart';
import 'package:flower_last/utils/util_baidu_flower_recognition.dart';
import 'package:flower_last/utils/util_encrypt.dart';
import 'package:flutter/material.dart';

class Flowers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FlowersState();
}

class FlowersState extends State<Flowers> {
  ///用户上传的图片url集合
  List<String> imgs = [
    'https://img2.mukewang.com/szimg/59b8a486000107fb05400300.jpg',
    'https://img2.mukewang.com/szimg/59b8a486000107fb05400300.jpg',
    'https://img2.mukewang.com/szimg/59b8a486000107fb05400300.jpg',
    'https://img2.mukewang.com/szimg/59b8a486000107fb05400300.jpg',
//    'https://img2.mukewang.com/szimg/59b8a486000107fb05400300.jpg',
//    'https://img2.mukewang.com/szimg/59b8a486000107fb05400300.jpg',
//    'https://img2.mukewang.com/szimg/59b8a486000107fb05400300.jpg',
//    'https://img2.mukewang.com/szimg/59b8a486000107fb05400300.jpg',
  ];

  /// 点赞的用户头像url列表
  List<String> userImgs = [
    'https://img2.mukewang.com/szimg/59b8a486000107fb05400300.jpg',
    'https://img2.mukewang.com/szimg/59b8a486000107fb05400300.jpg',
    'https://img2.mukewang.com/szimg/59b8a486000107fb05400300.jpg',
    'https://img2.mukewang.com/szimg/59b8a486000107fb05400300.jpg',
    'https://img2.mukewang.com/szimg/59b8a486000107fb05400300.jpg',
    'https://img2.mukewang.com/szimg/59b8a486000107fb05400300.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(56)),
            _buildUserRow(),
            _buildCenterText(),
            _buildCenterImg(),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  /// 覆盖在页面上的view，可以模拟实现toast和dialog,进度条，悬浮窗等控件
  showOverlay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return Center(
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.pinkAccent,
        ),
      );
    });
    OverlayEntry overlayEntry2 = OverlayEntry(builder: (context) {
      return Center(
        child: Container(
          height: 50.0,
          width: 50.0,
          color: Colors.tealAccent,
          child: CircularProgressIndicator(),
        ),
      );
    });

    overlayState.insert(overlayEntry);
    overlayState.insert(overlayEntry2);

    await Future.delayed(Duration(seconds: 2));

    overlayEntry.remove();
    overlayEntry2.remove();
  }

  ///顶部 个人信息条
  _buildUserRow() {
    return Container(
      height: 60,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FlowerRecognitionUtil.getAccessToken();
            },
            child: ClipOval(
              child: Image.asset(
                'imgs/guide_5.png',
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //横轴方向
//            mainAxisAlignment: MainAxisAlignment.center, //主轴方向居中， 外部布局时row，默认纵轴时居中，所以两种方式居中，一个是MainAxisSize.max + MainAxisAlignment.center，二是 MainAxisSize.min，使colum  wracontent，利用row的居中
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      '红太阳',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    Text(
                      '郑州市',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  '29分钟前',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 中部文字
  _buildCenterText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text('这是在菜市场买的花'),
    );
  }

  ///中部九宫格图片
  _buildCenterImg() {
    double width = MediaQuery.of(context).size.width;
    double height = width / 3;
    if (imgs.length <= 3) {
      height = height + 20;
    } else if (imgs.length <= 6) {
      height = height * 2 + 20;
    } else {
      height = width + 20;
    }

    return Container(
      height: height,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
          itemCount: imgs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imgs[index],
                fit: BoxFit.cover,
              ),
            );
          }),
    );
  }

  /// 底部评论 点赞
  _buildBottom() {
    List<String> localImgs = [];
    if (userImgs.length <= 3) {
      localImgs = userImgs;
    } else {
      localImgs = userImgs.sublist(userImgs.length - 3);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: localImgs.length * 30.00,
              height: 25,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: localImgs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 5),
                      child: ClipOval(
                        child: Image.network(
                          localImgs[index],
                          height: 25,
                          width: 25,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
            Padding(padding: EdgeInsets.only(left: 5)),
            Text(
              userImgs.length <= 3 ? '已点赞' : '等${userImgs.length}人已点赞',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.remove_red_eye,
              size: 18,
              color: Colors.grey,
            ),
            Text('64', style: TextStyle(fontSize: 12, color: Colors.grey)),
            Padding(padding: EdgeInsets.only(left: 10)),
            Icon(
              Icons.thumb_up,
              size: 18,
              color: Colors.grey,
            ),
            Text('15', style: TextStyle(fontSize: 12, color: Colors.grey)),
            Padding(padding: EdgeInsets.only(left: 10)),
            Icon(
              Icons.comment,
              size: 18,
              color: Colors.grey,
            ),
            Text('11', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
