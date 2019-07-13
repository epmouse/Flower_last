
class XCTestModel {

  final Head head;
  final List<XCTestItemModel> data;

	XCTestModel.fromJsonMap(Map<String, dynamic> map): 
		head = Head.fromJsonMap(map["head"]),
		data = List<XCTestItemModel>.from(map["data"].map((it) => XCTestItemModel.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['head'] = head == null ? null : head.toJson();
		data['data'] = data != null ? 
			this.data.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}

class Head {

	final Object auth;
	final int errcode;

	Head.fromJsonMap(Map<String, dynamic> map):
				auth = map["auth"],
				errcode = map["errcode"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['auth'] = auth;
		data['errcode'] = errcode;
		return data;
	}
}

class XCTestItemModel {

	final String word;
	final String type;
	final String price;
	final String star;
	final String zonename;
	final String districtname;
	final String url;

	XCTestItemModel.fromJsonMap(Map<String, dynamic> map):
				word = map["word"],
				type = map["type"],
				price = map["price"],
				star = map["star"],
				zonename = map["zonename"],
				districtname = map["districtname"],
				url = map["url"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['word'] = word;
		data['type'] = type;
		data['price'] = price;
		data['star'] = star;
		data['zonename'] = zonename;
		data['districtname'] = districtname;
		data['url'] = url;
		return data;
	}
}
