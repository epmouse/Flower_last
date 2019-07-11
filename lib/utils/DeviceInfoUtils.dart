import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceInfo {
  static final DeviceInfo _deviceInfo = DeviceInfo._init();
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static AndroidDeviceInfo _androidDeviceInfo;
  static IosDeviceInfo _iosDeviceInfo;

  AndroidDeviceInfo get androidDeviceInfo => _androidDeviceInfo;

  IosDeviceInfo get iosDeviceInfo => _iosDeviceInfo;

  _getDeviceInfo() async {
    if (Platform.isAndroid)
      _androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    if (Platform.isIOS) _iosDeviceInfo = await deviceInfoPlugin.iosInfo;
  }

  DeviceInfo._init() {
    _getDeviceInfo();
  }

  static DeviceInfo getInstance() {
    return _deviceInfo;
  }
}
