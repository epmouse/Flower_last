import 'package:flower_last/utils/util_input.dart';
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

class WebViewPageState extends State<WebViewPage> with WidgetsBindingObserver {
  WebViewArguments _arguments;
  FocusNode _focusNodeDescription = new FocusNode();
  int bottomCommentFlex = 1;
  bool inputIsHide = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    setState(() {
      bottomCommentFlex = inputIsHide ? 1 : 2;
    });
    inputIsHide = !inputIsHide;
  }

  @override
  Widget build(BuildContext context) {
    _arguments = ModalRoute.of(context).settings.arguments;
    setStatusColor();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: _getWebViewScaffold(),
            flex: 10,
          ),

          Expanded(
            flex: bottomCommentFlex,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(blurRadius: 2, color: Colors.grey
//                    offset: Offset(0, -10),
                  )
                ],
              ),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.search),onPressed: (){
                  },),
                  Expanded(
                    child: buildInput(),
                  ),
                  Text('right'),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
   /// 该input框所写评论会显示到h5页面底部。todo- 考虑是直接与js交互把评论传过去，还是先把平路提交，h5再请求。
  Container buildInput() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      alignment: Alignment.bottomCenter,
      child: TextField(
        onTap: () {},
        focusNode: _focusNodeDescription,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey[300], width: 0.5)),
          filled: false, //是否填充input框
//                    fillColor: Colors.grey,//input框的填充颜色
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey[300], width: 0.5)),
        ),
      ),
    );
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
