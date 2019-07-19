import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceInfo {
  static final DeviceInfo _deviceInfo = DeviceInfo._init();
  static AndroidDeviceInfo _androidDeviceInfo;
  static IosDeviceInfo _iosDeviceInfo;

  AndroidDeviceInfo get androidDeviceInfo => _androidDeviceInfo;

  IosDeviceInfo get iosDeviceInfo => _iosDeviceInfo;

  DeviceInfo._init() {
    getDeviceInfo();
  }

  static DeviceInfo getInstance() {
    return _deviceInfo;
  }

  getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if (Platform.isAndroid) {
      _androidDeviceInfo = await deviceInfo.androidInfo;
      print(_readAndroidBuildData(_androidDeviceInfo).toString());
    } else if (Platform.isIOS) {
      _iosDeviceInfo = await deviceInfo.iosInfo;
      print(_readIosDeviceInfo(_iosDeviceInfo).toString());
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  getDeviceId(){
    if (Platform.isAndroid) {
      return _androidDeviceInfo.androidId;
    } else if (Platform.isIOS) {
      return _iosDeviceInfo.identifierForVendor;
    }
  }
}
