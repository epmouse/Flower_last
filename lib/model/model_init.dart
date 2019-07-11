class InitModel {
  final bool isNewRecord;
  final String id;
  final String appName;
  final int themeColor;
  final String appType;
  final String appBaseUrl;
  final String splashImgUrl;
  final String remark;
  final List<BottomNavs> bottomNavs;

  InitModel({this.isNewRecord, this.id, this.appName, this.themeColor,
      this.appType, this.appBaseUrl, this.splashImgUrl, this.remark,
      this.bottomNavs});

  InitModel.fromJsonMap(Map<String, dynamic> map)
      : isNewRecord = map["isNewRecord"],
        id = map["id"],
        appName = map["appName"],
        themeColor = map["themeColor"],
        appType = map["appType"],
        appBaseUrl = map["appBaseUrl"],
        splashImgUrl = map["splashImgUrl"],
        remark = map["remark"],
        bottomNavs = List<BottomNavs>.from(
            map["bottomNavs"].map((it) => BottomNavs.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isNewRecord'] = isNewRecord;
    data['id'] = id;
    data['appName'] = appName;
    data['themeColor'] = themeColor;
    data['appType'] = appType;
    data['appBaseUrl'] = appBaseUrl;
    data['splashImgUrl'] = splashImgUrl;
    data['remark'] = remark;
    data['bottomNavs'] = bottomNavs != null
        ? this.bottomNavs.map((v) => v.toJson()).toList()
        : null;
    return data;
  }
}

class BottomNavs {
 final bool isNewRecord;
 final String id;
 final String icon;
 final String activeIcon;
 final String title;
 final String url;
 final String remark;

  BottomNavs.fromJsonMap(Map<String, dynamic> map)
      : isNewRecord = map["isNewRecord"],
        id = map["id"],
        icon = map["icon"],
        activeIcon = map["activeIcon"],
        title = map["title"],
        url = map["url"],
        remark = map["remark"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isNewRecord'] = isNewRecord;
    data['id'] = id;
    data['icon'] = icon;
    data['activeIcon'] = activeIcon;
    data['title'] = title;
    data['url'] = url;
    data['remark'] = remark;
    return data;
  }
}
