import 'package:flower_last/model/model_bottom_nav.dart';
import 'package:flower_last/pages/LoginPage.dart';
import 'package:flower_last/pages/page_flowers.dart';
import 'package:flower_last/pages/page_home.dart';
import 'package:flower_last/pages/page_knowlege.dart';
import 'package:flower_last/pages/page_me.dart';
import 'package:flower_last/utils/util_sp.dart';
import 'package:flutter/material.dart';

class MainNavPage extends StatefulWidget {
  static const routerName = '/main';
  final List<BottomNavModel> bottomItems;

  MainNavPage({this.bottomItems}) : super();

  @override
  _MainNavPageState createState() {
    return _MainNavPageState();
  }
}

class _MainNavPageState extends State<MainNavPage> {
  final pages = [Home(), Me()];
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  bool isSplash = false;

  @override
  void initState() {
    super.initState();
    SpUtils.setSp(SpUtils.isToGuide, false);
  }

  @override
  Widget build(BuildContext context) {
    return _buildMainPage(context);
  }

  ///创建主页面
  Scaffold _buildMainPage(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), //圆形缺口
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.only(right: 30),
              icon: Icon(
                Icons.home,
                color: _currentIndex == 0 ? Colors.green : Colors.grey,
              ),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                  _pageController.jumpToPage(_currentIndex);
                });
              },
            ),
//            Opacity(opacity: 0,child:IconButton(
//              icon: Icon(Icons.airplay),
//              color: Colors.white,
//              onPressed: (){
////                setState(() {
////                  _index = 1;
////                });
//              },
//            ),),

            IconButton(
              padding: EdgeInsets.only(left: 30),
              icon: Icon(
                Icons.airplay,
                color: _currentIndex == 1 ? Colors.green : Colors.grey,
              ),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                  _pageController.jumpToPage(_currentIndex);
                });
              },
            ),
          ],
        ),
      ),

      body: PageView.builder(
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _pageController,
        itemBuilder: (context, index) {
          return pages[index];
        },
        itemCount: pages.length,
      ),
    );
  }

  _bottomNavItemBuild() {
    if (widget.bottomItems == null)
      return _getDefaultBottomItems();
    else
      return _getRemoteItems();
  }

  _getDefaultBottomItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
      BottomNavigationBarItem(
          icon: Icon(Icons.local_florist), title: Text('花园')),
      BottomNavigationBarItem(
          icon: Icon(Icons.laptop_chromebook), title: Text('知识')),
      BottomNavigationBarItem(
          icon: Icon(Icons.accessibility_new), title: Text('我')),
    ];
  }

  ///下载远程图标
  _getRemoteItems() {}
}
