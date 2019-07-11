import 'package:flower_last/utils/util_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  static const routeName = '/webview';

  @override
  createState() {
    return WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage> {
  WebViewArguments _arguments;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _arguments = ModalRoute.of(context).settings.arguments;
    setStatusColor();
    return _getWebViewScaffold();
  }

  Widget _getWebViewScaffold() {
    if (_arguments.isHideTitle) {
      //隐藏标题
      if (_arguments.isHideStatus) {
        //并且隐藏状态栏
        return WebviewScaffold(
          url: _arguments.url,
          withJavascript: true,
          scrollBar: false,
          withLocalUrl: true,
        );
      } else {
        return SafeArea(
            child: WebviewScaffold(
          url: _arguments.url,
          withJavascript: true,
          scrollBar: false,
          withLocalUrl: true,
        ));
      }
    } else {
      return WebviewScaffold(
        url: _arguments.url,
        withJavascript: true,
        scrollBar: false,
        withLocalUrl: true,
        appBar: AppBar(
          backgroundColor: _arguments.titleColor,
          title: Text(_arguments.title),
        ),
      );
    }
  }

  setStatusColor() {
    StatusBarUtils.setStatusColor(
        _arguments.titleColor, _arguments.statusBarFontColor);
  }
}

class WebViewArguments {
  final String url;
  final String title;
  final Color titleColor;
  final Brightness statusBarFontColor;
  final bool isHideTitle;
  final bool isHideStatus;

  WebViewArguments(this.url,
      {this.title,
      this.titleColor,
      this.statusBarFontColor,
      this.isHideTitle,
      this.isHideStatus});
}
