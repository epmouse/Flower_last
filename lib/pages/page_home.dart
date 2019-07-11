import 'package:flower_last/api/api_class.dart';
import 'package:flower_last/pages/page_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
//  final List<MainPageModel> mainData = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('第一页'),
      ),
//      body: ListView.builder(
//        itemBuilder: (context, index) {
//          Widget widget;
//          MainPageModel mainPageModel = mainData[index];
//          switch (mainPageModel.itemType) {
//            case "normal": //正常条目
//              break;
//            case "title": //标题类型 todo- 考虑把标题数据移到对应的条目中
//              break;
//            case "banner":
//              widget = Swiper(
//                itemBuilder: (context,index){
//
//                },
//
//                itemCount: ,
//                pagination: SwiperPagination(
//                  builder: DotSwiperPaginationBuilder(
//                    color: ,
//                    activeColor: ,
//                    activeSize: ,
//                    size: ,
//                  ),
//                ),
//                autoplay: true,
//                scrollDirection: Axis.horizontal,
//                onTap: (index){
//
//                },
//              );
//              break;
//            case "horizontalListView":
//              break;
//            case "dynamicButtons":
//              break;
//            case "webItem":
//              break;
//            case "tips":
//              break;
//          }
//        },
//        itemCount: mainData.length,
//      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initData() {
    IApi api = FlowerApi();
    api.getRequestForResults('').then((data) {});
  }
}
