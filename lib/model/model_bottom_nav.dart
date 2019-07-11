
class BottomNavModel {

  final String icon;
  final String activeIcon;
  final String title;

	BottomNavModel.fromJsonMap(Map<String, dynamic> map):
		icon = map["icon"],
		activeIcon = map["activeIcon"],
		title = map["title"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['icon'] = icon;
		data['activeIcon'] = activeIcon;
		data['title'] = title;
		return data;
	}
}
