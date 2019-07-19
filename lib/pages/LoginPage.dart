import 'package:dio/dio.dart';
import 'package:flower_last/utils/util_wechat.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
//    WeChatLogin.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).accentColor,
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              color: Colors.white,
              margin: EdgeInsets.all(20),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: Container(
                padding: EdgeInsets.only(bottom: 40, left: 30, right: 30),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 30, bottom: 10),
                      child: Icon(
                        Icons.local_florist,
                        size: 90,
                        color: Colors.green,
                      ),
                    ),
                    TextField(
                      onSubmitted: (text) {},
                      controller: _userNameController,
                      autofocus: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          icon: Icon(Icons.supervisor_account),
                          hintText: '请输入注册的手机号',
                          labelText: '手机号',
                          //为true则进入页面时自动获取焦点，默认为false
                          suffixIcon: GestureDetector(
                            onTap: () {
                              //todo- 调用获取验证码接口
                            },
                            child: Container(
                              margin: EdgeInsets.all(6),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '获取验证码',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          )),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    TextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        icon: Icon(Icons.vpn_key),
                        hintText: '请输入密码',
                      ),
                      autofocus: false, //为true则进入页面时自动获取焦点，默认为false
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      margin: EdgeInsets.only(top: 50),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Theme.of(context).accentColor,
                        child: Text(
                          '登录',
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(
                              FocusNode()); //点击登录按钮使所有输入框都失去焦点，从而隐藏软件盘。
                          final userName = _userNameController.text;
                          final password = _passwordController.text;
                          if (userName == null || userName.length == 0) {
                            Fluttertoast.showToast(msg: '请先输入用户名');
                            return;
                          }
                          if (password == null || password.length == 0) {
                            Fluttertoast.showToast(msg: '请先输入验证码');
                            return;
                          }

                          Future.delayed(Duration(seconds: 2), () {
                            Fluttertoast.showToast(msg: '登录成功');
                            Navigator.maybePop(context); //关闭登录页
                          });
                        },
                      ),
                    ),

                     ///考虑每次登录都使用短信验证码，所以去掉忘记密码和立即注册的操作。
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        FlatButton(
//                          onPressed: () {
//                            //todo-忘记密码的操作
//                          },
//                          child: Text('忘记密码?'),
//                        ),
//                        FlatButton(
//                          onPressed: () {
//                            //todo-跳转到注册页面
//                          },
//                          child: Text('立即注册'),
//                        ),
//                      ],
//                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    GestureDetector(
                      onTap: () {
                        _toWeChatLogin();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            AntDesign.getIconData('wechat'),
                            color: Colors.green,
                            size: 30,
                          ),
                          Padding(padding: EdgeInsets.all(3)),
                          Text(
                            '微信登录',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//跳转到微信登录
  void _toWeChatLogin() {
    WeChatUtils.sendAuth();
  }
}
