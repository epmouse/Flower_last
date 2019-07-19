import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FlowerInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) {
    int l1 = DateTime.now().millisecondsSinceEpoch;




//    DeviceInfo.get
//    String deviceType = Utils.getPhoneModel();
//    String version = Utils.getVersionName();
//    String systemVersion = Utils.getBuildVersion();
//    String deviceNo = Utils.getDeviceId(App.getInstance());
//    deviceNo = deviceNo == null ? "" : deviceNo;
//    String appSecret = "ZyCFc20170309121212567GFNMUAAAAA";
//    String sign;
//    sign = timeStamp + deviceNo;
//    try {
//      sign = SignatureUtil.encryptAES((timeStamp + deviceNo), appSecret);
//    } catch (Exception e) {
//    e.printStackTrace();
//    }
//    sign = Utils.getValueEncoded(sign);
//    String command =  Hawk.get(HawkKey.COMMAND);
//    command = command == null ? "" : command;
//    Request.Builder builder = request1.newBuilder()
//        .addHeader("channel", "12")
//        .addHeader("deviceType", deviceType)
//        .addHeader("version", version)
//        .addHeader("deviceNo", deviceNo)
//        .addHeader("systemVersion", systemVersion)
//        .addHeader("sign", sign)
//        .addHeader("commond", command)
//        .addHeader("pushId", pushId);
//
//    User user = UserInfoManager.getUser(UserInfoManager.getTempUserName());
//    if (user != null) {
//    builder.addHeader("userId", user.getId());
//    }

    return '';
  }

  @override
  onResponse(Response response) {}
}
