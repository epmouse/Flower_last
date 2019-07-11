import 'package:flower_last/utils/util_dialog.dart';
import 'package:flower_last/utils/util_status_bar.dart';
import 'package:flower_last/widgets/widget_search_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Search extends StatefulWidget {
  static const routerName = '/search';

  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<Search> {
  SearchModel _arguments;

  List<String> _searchResults = [];

  bool _textFieldNotEmpty = false;

  bool _hideWrap = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _arguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _getSearchListView(),
          _getSearchTitle(),
          Offstage(
            offstage: _hideWrap,
            child: Container(
              margin: EdgeInsets.only(
                  left: 10,
                  top: 56 + StatusBarUtils.getStatusBarHeight(context)),
              child: _getHotSearch(),
            ),
          ),
        ],
      ),
    );
  }

  _getSearchTitle() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey[600])],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: _arguments.bgColor,
            height: StatusBarUtils.getStatusBarHeight(context),
          ),
          SearchTitleBar(
            bgColor: _arguments.bgColor,
            onChanged: (String result) {
              DialogUtils.showFlowerDialog(
                  context: context, canDismissible: false);
              _textFieldNotEmpty = result != null && result.length != 0;
              toSearch(result);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 输入框状态改变时调用搜索接口展示搜索结果
  _getSearchListView() {
    return ListView.builder(
      padding: EdgeInsets.only(
        top: 56 + StatusBarUtils.getStatusBarHeight(context),
      ),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_searchResults[index]),
        );
      },
      itemCount: _searchResults.length,
    );
  }

  /// 调用接口搜索，此接口只返回包含关键字的标题，用户点击展示后的标题才搜索对应条目并跳转页面展示
  void toSearch(String result) {
    Future.delayed(Duration(seconds: 3), () {
      _searchResults.clear();
      if (_textFieldNotEmpty) {
        _searchResults.add('$result >>>aaaaa');
        _searchResults.add('$result >>>bbbbb');
        _searchResults.add('$result >>>ccccc');
        _searchResults.add('$result >>>ddddd');
        _searchResults.add('$result >>>eeeee');
        _searchResults.add('$result >>>fffff');
        _searchResults.add('$result >>>ggggg');
        _searchResults.add('$result >>>hhhhh');
        _searchResults.add('$result >>>iiiii');
        _searchResults.add('$result >>>jjjjj');
        _hideWrapWidget();
      } else {
        _showWrapWidget();
      }
      setState(() {
        Navigator.pop(context);
      });
    });
  }

  /// 热门搜索关键词布局，
  _getHotSearch() {
    return ListView(
      children: <Widget>[
        Offstage(
          offstage: true,
          child: Container(),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: 10,
                ),
                alignment: Alignment.topLeft,
                child: Text(
                  '热搜关键词',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                children: _getWraps(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///返回流式布局内部数组
  _getWraps() {
    List<Widget> widgets = [];
    List<String> list = [
      '绿萝', '芦荟', '龟背竹', '发财树', '富贵竹', '牡丹', '香龙血树', '白蝴蝶', '朱焦', '栀子', '文竹', '万年青', '巴西铁', '铁树', '黑美人', '滴水观音', '袖珍椰子'
    ];
    for (String s in list) {
      widgets.add(
        GestureDetector(
          onTap: () {
            //todo - 拿到 s 调用搜索接口,如果直接涉
          },
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Text(
              s,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  /// 隐藏 热搜关键词和历史搜索关键词的wrap布局
  _hideWrapWidget() {
    _hideWrap = true;
  }

  /// 显示 热搜关键词和历史搜索关键词的wrap布局
  _showWrapWidget() {
    _hideWrap = false;
  }
}

class SearchModel {
  final Color bgColor;
  final Color rightTextColor;
  final Brightness statusBarFontColor;

  SearchModel(
      {this.bgColor = Colors.white,
      this.rightTextColor = Colors.grey,
      this.statusBarFontColor = Brightness.dark});
}
