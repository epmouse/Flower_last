import 'package:flower_last/api/api_class.dart';
import 'package:flower_last/model/model_init.dart';
import 'package:flower_last/pages/SplashPage.dart';
import 'package:flower_last/pages/page_guide.dart';
import 'package:flower_last/pages/page_main_docker.dart';
import 'package:flower_last/utils/routes_util.dart';
import 'package:flower_last/utils/util_sp.dart';
import 'package:flower_last/utils/util_wechat.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WeChatUtils.init();//初始化微信

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MainPage(),
      routes: MyRoutes.getRoutes(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  InitModel model;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Splash(
          onHideCallback: () {
            SpUtils.getSp<bool>(SpUtils.isToGuide).then((bool b) {
              Navigator.of(context)
                  .popAndPushNamed(b ? Guide.routerName : MainNavPage.routerName);
            }).catchError((e){
              if(e is MySpIsNullException){
                Navigator.of(context).popAndPushNamed(Guide.routerName);
              }
            });
//            Navigator.of(context).pushNamed(routeName)
          },
        ),
      ],
    );
  }

  void initData() {
    IApi api = FlowerApi();
    api.getRequestForResults('js/a/app/api/init').then((result) {
      model = InitModel.fromJsonMap(result);
//      setState(() {
//      });
    }).catchError((e) {});
  }
}
