import 'package:fluwx/fluwx.dart' as fluwx;

class WeChatUtils{
  static init(){
    fluwx.register(appId:"wxd930ea5d5a258f4f");
    fluwx.responseFromShare.listen((response){
      //do something
    });
    fluwx.responseFromAuth.listen((response){

      print('>>>登录Listener》$response');
      //do something
    });
    fluwx.responseFromPayment.listen((response){
      //do something
    });
  }
  
  static sendAuth(){
    fluwx.sendAuth(scope: 'snsapi_userinfo',state: 'wechat_sdk_demo_test').then((data){
      print('>>>>>>>auth返回>>>$data');
    });
  }
}