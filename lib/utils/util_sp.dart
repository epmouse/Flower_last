import 'package:shared_preferences/shared_preferences.dart';

class SpUtils {
  static const String isToGuide = 'isToGuide';//标识是跳转到引导页面还是主页

 static setSp<T>(String key, T t) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (t is String) {
      await sp.setString(key, t);
    } else if (t is double) {
      await sp.setDouble(key, t);
    } else if (t is int) {
      await sp.setInt(key, t);
    } else if (t is bool) {
      await sp.setBool(key, t);
    } else if (t is List<String>) {
      await sp.setStringList(key, t);
    } else {
      throw '不支持该类型存储';
    }
  }

 static Future<T> getSp<T>(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.get(key) as T;
  }
}
