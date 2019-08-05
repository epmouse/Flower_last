import 'package:flower_last/api/HttpUtils.dart';
import 'package:flower_last/utils/ImageUtils.dart';
import 'package:flower_last/utils/ImageUtils.dart';

class FlowerRecognitionUtil {
  static String accessToken = '';
  static getAccessToken() {
    var map = {
      'grant_type': 'client_credentials',
      'client_id': 'G8pi1hwUTA1j2rSFqFokXxOf',
      'client_secret': 'onvMKcxOWZ4HIWcP4Q7An9Yc0HFHmrrr'
    };
    final String tokenGetUrl = 'https://aip.baidubce.com/oauth/2.0/token';
    HttpUtils.getInstance().post(tokenGetUrl, data: map).then((data) {
      accessToken = data['refresh_token'];
      print('百度token= $accessToken');
      print(data);
    }).catchError((error){
      print(error);
    });
  }

  //识别
  static identify(String imgUrl) async {
    final String recognitionUrl = 'https://aip.baidubce.com/rest/2.0/image-classify/v1/flower';
//    String compressImgPath = await ImageUtils.compress(imgUrl);
//    ImageUtils.printSize(compressImgPath,flagText: '压缩后');
//    String imgBase64 = await ImageUtils.img2Base64ByPath(compressImgPath);
    String imgBase64 = await ImageUtils.img2Base64ByPath(imgUrl);
    return HttpUtils.getInstance().post(recognitionUrl, queryParameters: {'access_token':accessToken,'image':imgBase64});
  }
}
