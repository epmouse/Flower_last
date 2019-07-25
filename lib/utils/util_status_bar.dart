import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class StatusBarUtils {
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// statusBarBrightness  状态栏文字颜色  黑和白  Brightness.light   Brightness.dark
 static void setStatusColor({Color color = Colors.transparent,Brightness statusBarBrightness = Brightness.dark}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: statusBarBrightness,
    ));
  }
}
