import 'dart:async';
import 'package:flutter/material.dart';

///splash页面 倒计时组件
class CountDownWidget extends StatefulWidget {
  final onCountDownFinishedCallback;

  const CountDownWidget({Key key, @required this.onCountDownFinishedCallback})
      : super(key: key);

  @override
  createState() => CountDownState();
}

class CountDownState extends State<CountDownWidget> {
  var _currentTime = 4;
  final duration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Text('$_currentTime',
          style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              decoration: TextDecoration.none)),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  _startTimer() {
    Future.delayed(duration, () {
      if (!mounted) return;
      _currentTime--;
      if (_currentTime == 0) {
        widget.onCountDownFinishedCallback();
      } else {
        _startTimer();
      }
      setState(() {});
    });
  }
}
