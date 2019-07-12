import 'package:flower_last/model/model_main_item.dart';

///首页根model
class MainPageModel {

  final List<MainPageItemModel> itemData;

	MainPageModel.fromJsonMap(Map<String, dynamic> map):
		itemData = List<MainPageItemModel>.from(map["data"].map((it) => MainPageItemModel.fromJson(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['data'] = data != null ? 
			this.itemData.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
