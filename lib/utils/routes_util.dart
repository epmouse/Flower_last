import 'package:flower_last/pages/page_guide.dart';
import 'package:flower_last/pages/page_main.dart';
import 'package:flower_last/pages/page_search.dart';
import 'package:flower_last/pages/page_webview.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      WebViewPage.routeName: (context) => WebViewPage(),
      Search.routerName: (context) => Search(),
      Guide.routerName: (context) => Guide(),
      MainNavPage.routerName: (context) => MainNavPage(),
    };
  }
}
