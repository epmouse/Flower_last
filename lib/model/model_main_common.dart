///首页接口条目中的子条目model，通用model
class MainCommonModel {
  final bool isNewRecord;
  final String id;
  final String itemType;
  final String imgUrl;
  final String clickAction;
  final int titleColor;
  final String title;
  final String remark;

  MainCommonModel.fromJson(Map<String, dynamic> json)
      : isNewRecord = json['isNewRecord'],
        id = json['id'],
        itemType = json['itemType'],
        imgUrl = json['imgUrl'],
        clickAction = json['clickAction'],
        titleColor = json['titleColor'],
        title = json['title'],
        remark = json['remark'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isNewRecord'] = this.isNewRecord;
    data['id'] = this.id;
    data['itemType'] = this.itemType;
    data['imgUrl'] = this.imgUrl;
    data['clickAction'] = this.clickAction;
    data['titleColor'] = this.titleColor;
    data['title'] = this.title;
    data['remark'] = this.remark;
    return data;
  }
}
