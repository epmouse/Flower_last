import 'package:flower_last/utils/util_camera.dart';
import 'package:flower_last/utils/util_wechat.dart';

class InitUtils{
  static init(){
    WeChatUtils.init();//初始化微信
    CameraUtils.init();//初始化camera，用户camera库的使用
  }
}