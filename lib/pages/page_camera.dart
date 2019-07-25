import 'dart:async';
import 'dart:io';
import 'package:flower_last/utils/screen_utils.dart';
import 'package:flower_last/utils/util_camera.dart';
import 'package:flower_last/utils/util_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() {
    return _CameraPageState();
  }
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;

  String imagePath;
  bool isTaking = true; //在做拍照操作。
  final shadowColor = Color(2852126720); //中间方框内全透明，方框外暗影处理

  @override
  void initState() {
    super.initState();
    controller =
        CameraController(CameraUtils.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarUtils.setStatusColor(statusBarBrightness: Brightness.light);
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Stack(
        children: <Widget>[
          CameraPreview(controller),
          Offstage(
            offstage: isTaking,
            child: Container(
              height: double.infinity,
              child: isTaking
                  ? SizedBox()
                  : Image.file(
                      File(imagePath),
                      fit: BoxFit.fill,
                    ),
            ),
          ),
          Column(
            children: <Widget>[
              _getOutsideShadow(double.infinity,100),
              // 拍照界面中间矩形框
              Row(
                children: <Widget>[
                  _getOutsideShadow((ScreenUtils.getInstance().screenWidth - 250) / 2,250),
                  Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.white,
                        width: 0.5,
                      ),
                    ),
                  ),
                  _getOutsideShadow((ScreenUtils.getInstance().screenWidth - 250) / 2,250),
                ],
              ),

              Expanded(
                child: _getOutsideShadow(null,null)
              ),
            ],
          ),
          Offstage(
            offstage: !isTaking,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CameraBottomActionWidget(controller, (String imgPath) {
                imagePath = imgPath;
                isTaking = false;
                setState(() {});
              }),
            ),
          ),
        ],
      ),
    );
  }

  Container _getOutsideShadow(double width,double height) {
    return Container(
      color: shadowColor,
      height: height,
      width: width,
    );
  }
}

class CameraBottomActionWidget extends StatefulWidget {
  final CameraController cameraController;
  final imagePathCallback;

  CameraBottomActionWidget(this.cameraController, this.imagePathCallback);

  @override
  State<StatefulWidget> createState() {
    return CameraBottomActionWidgetState();
  }
}

class CameraBottomActionWidgetState extends State<CameraBottomActionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildButton('相册', Icons.image),
          GestureDetector(
            onTap: () {
              _onTakePhoto();
            },
            child: Icon(
              Icons.radio_button_checked,
              size: 70,
              color: Colors.white,
            ),
          ),
          _buildButton('闪光灯', Icons.flash_on),
        ],
      ),
    );
  }

  /// 左右按钮  打开相册  闪光灯
  _buildButton(String text, IconData image) {
    return Padding(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              image,
              color: Colors.white,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 12,decoration: TextDecoration.none),
            ),
          ],
        ));
  }

  void _onTakePhoto() {
    takePicture().then((imgPath) {
      if (imgPath != null && widget.cameraController != null) {
        widget.imagePathCallback(imgPath);
      }
    });
  }

  ///拍照
  takePicture() async {
    if (!widget.cameraController.value.isInitialized) {
      Fluttertoast.showToast(msg: '摄像头没有准备好！', timeInSecForIos: 1);
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String imgPath = '${extDir.path}/photo_${_getCurrentTime()}.jpg';
    if (widget.cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await widget.cameraController.takePicture(imgPath);
    } on CameraException catch (e) {
      Fluttertoast.showToast(
          msg: '拍摄照片异常,' + e.description, timeInSecForIos: 1);
      return null;
    }
    return imgPath;
  }

  _getCurrentTime() => DateTime.now().millisecondsSinceEpoch;
}
