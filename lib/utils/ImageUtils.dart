import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

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
}
