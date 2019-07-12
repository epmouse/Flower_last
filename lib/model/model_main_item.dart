
import 'package:flower_last/model/model_main_common.dart';

/// 首页条目model
class MainPageItemModel {

  final bool isNewRecord;
  final String id;
  final String itemType;
  final String title;
  final String subTitle;
  final String leftImg;
  final String rightText;
  final String clickAction;
  final int titleColor;
  final String remark;
  final List<MainCommonModel> normalDatas;

	MainPageItemModel.fromJson(Map<String, dynamic> map):
		isNewRecord = map["isNewRecord"],
		id = map["id"],
		itemType = map["itemType"],
		title = map["title"],
		subTitle = map["subTitle"],
		leftImg = map["leftImg"],
		rightText = map["rightText"],
		clickAction = map["clickAction"],
		titleColor = map["titleColor"],
		remark = map["remark"],
		normalDatas  = List<MainCommonModel>.from(map["normalDatas"].map((it) => MainCommonModel.fromJson(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['isNewRecord'] = isNewRecord;
		data['id'] = id;
		data['itemType'] = itemType;
		data['title'] = title;
		data['subTitle'] = subTitle;
		data['leftImg'] = leftImg;
		data['rightText'] = rightText;
		data['clickAction'] = clickAction;
		data['titleColor'] = titleColor;
		data['remark'] = remark;
		data['normalDatas'] = data != null ?
		this.normalDatas.map((v) => v.toJson()).toList()
				: null;
		return data;
	}
}
