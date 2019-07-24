import 'dart:async';
import 'package:flower_last/utils/util_camera.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() {
    return _CameraPageState();
  }
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;

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
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Stack(
        children: <Widget>[CameraPreview(controller), Center(
          child: Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
            color: Colors.transparent,
             border: Border.all(
               color: Colors.amber,
               width: 0.3,
             ),
            ),
          ),
        ), ],
      ),
    );
  }
}
