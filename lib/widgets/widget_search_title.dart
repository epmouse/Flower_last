import 'package:flutter/material.dart';

class SearchTitleBar extends StatefulWidget {
  final Color bgColor;
  final Color rightTextColor;
  final ValueChanged<String> onChanged;

  SearchTitleBar({
    this.bgColor = Colors.white,
    this.rightTextColor = Colors.grey,
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() {
    return SearchTitleBarState();
  }
}

class SearchTitleBarState extends State<SearchTitleBar> {
  TextEditingController _textController;
  bool _noText = true;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
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
          Expanded(
            child: _getInput(),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text(
              '取消',
              style: TextStyle(fontSize: 14, color: widget.rightTextColor),
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
          color: Colors.grey[200],
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
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
                controller: _textController,
                //初始搜索值（非hintText）
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  _resetOffstage();
                  widget.onChanged(text);
                  //todo 请求搜索接口
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
