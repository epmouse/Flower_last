import 'package:flower_last/pages/page_search.dart';
import 'package:flutter/material.dart';

class SearchTitleBar extends StatefulWidget {
  final Color bgColor; //整个标题背景色
  //输入框的背景颜色
  final Color inputBgColor;
  final Color InputBorderColor;

  //可定制左边的widget
  final Widget leftWidget;

  //可定制右边的widget
  final Widget rightWidget;

  //输入框text变动的监听
  final ValueChanged<String> onChanged;

  //是否可输入
  final bool inputEnable;

  final TextEditingController textController;
  SearchTitleBar({
    this.bgColor = Colors.white,
    this.inputBgColor,
    this.InputBorderColor,
    this.leftWidget,
    this.rightWidget,
    this.onChanged,
    this.inputEnable = true,
    this.textController,
  });

  @override
  State<StatefulWidget> createState() {
    return SearchTitleBarState();
  }
}

class SearchTitleBarState extends State<SearchTitleBar> {
  TextEditingController _textController ;
  bool _noText = true;

  @override
  void initState() {
    super.initState();
    _textController = widget.textController?? TextEditingController();//外部传进来则使用外部的，没有传再new出来
    _resetOffstage();
  }

  @override
  Widget build(BuildContext context) {
    return _getSearchTitle();
  }

  _getSearchTitle() {
    return Container(
      decoration: BoxDecoration(
        color: widget.bgColor,
      ),
      height: 56,
      child: Row(
        children: <Widget>[
          Container(
            child: widget.leftWidget ?? Padding(padding: EdgeInsets.all(0)),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!widget.inputEnable) {
                  Navigator.of(context)
                      .pushNamed(Search.routerName, arguments: SearchModel());
                }
              },
              child: _getInput(),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: widget.rightWidget ??
                Text(
                  '取消',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
        ],
      ),
    );
  }

  /// 搜索框
  _getInput() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.only(
        left: 5,
      ),
      alignment: Alignment.center,
      height: 32,
      decoration: BoxDecoration(
          color: widget.inputBgColor ?? Colors.grey[200],
          border: Border.all(
              width: 0.5, color: widget.InputBorderColor ?? Colors.grey[200]),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.search,
            color: Colors.grey,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 5),
              child: TextField(
                enabled: widget.inputEnable,
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
                controller: _textController,
                autofocus: widget.inputEnable,
                //不可输入时不自动获取焦点
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  _resetOffstage();
                  widget.onChanged(text); //抛出去
                },
              ),
            ),
          ),
          Offstage(
            offstage: _noText,
            child: GestureDetector(
              onTap: () {
                _textController.text = '';
                _resetOffstage();
                widget.onChanged('');
              },
              child: Container(
                //给容器宽度，增大icon的点击区域。
                width: 40,
                height: 30,
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.clear,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///重置搜索框的清空按钮状态，搜索框文字为空则隐藏
  _resetOffstage() {
    setState(() {
      _noText =
          _textController.text == null || _textController.text.length == 0;
    });
  }
}
