import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  static takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    print(">>>>>${image.path}");
    return image;
  }

//  static Future<void> loadAssets() async {
//    List<Asset> resultList = List<Asset>();
//    String error = 'No Error Dectected';
//    List<Asset> images = List<Asset>();
//
//    try {
//      resultList = await MultiImagePicker.pickImages(
//          maxImages: 300,
//          enableCamera: true,
//          selectedAssets: images,
//          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//          materialOptions: MaterialOptions(
//            actionBarColor: "#abcdef",
//            actionBarTitle: "Example App",
//            allViewTitle: "All Photos",
//            selectCircleStrokeColor: "#000000",
//          ));
//
//      print(">>>>>>_______${resultList}");
//    } on PlatformException catch (e) {
//      error = e.message;
//    }
//  }

  static Future<String> compress(String imgPath, {String tempDir}) async {
    if (imgPath == null || File(imgPath) == null) return null;
    printSize(imgPath,flagText: '压缩前');
    //压缩后的图片存放地址
    final Directory temDir = await getTemporaryDirectory();
    CompressObject compressObject = CompressObject(
        imageFile: File(imgPath), path: temDir.path, quality: 85, step: 6);
    return Luban.compressImage(compressObject);
  }
  ///通过图片地址把图片转换为base64
  static Future<String> img2Base64ByPath(String imgPath) async {
    File file = File(imgPath??"");
    List<int> imgBytes = await file?.readAsBytes();
    return base64Encode(imgBytes);

  }
  /// imgPath 图片路径
  /// flagText 打印信息的标识（前缀）
  static void printSize(String imgPath,{String flagText})async {
    File file = File(imgPath);
    List<int> bytes = await file.readAsBytes();
    print('$flagText 大小 = ${file.length()}');
    print('$flagText 大小bytes = ${bytes.length}');
  }
}
