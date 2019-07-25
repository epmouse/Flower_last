import 'package:flower_last/api/api_class.dart';
import 'package:flower_last/model/model_main.dart';
import 'package:flower_last/model/model_main_common.dart';
import 'package:flower_last/model/model_main_item.dart';
import 'package:flower_last/pages/page_search.dart';
import 'package:flower_last/pages/page_webview.dart';
import 'package:flower_last/utils/screen_utils.dart';
import 'package:flower_last/utils/util_dialog.dart';
import 'package:flower_last/utils/util_status_bar.dart';
import 'package:flower_last/widgets/widget_search_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController(); //listview的控制器

  double _searchTitleOpacity = 0;
  MainPageModel _mainPageModel;
  Widget _mainWidget;

  var _isLoading = true;

  var _isNotEmpty = true; //数据不为空

  @override
  void initState() {
    super.initState();

    initData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ///加载更多触发

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    StatusBarUtils.setStatusColor(color: Colors.transparent, statusBarBrightness: Brightness.dark); //statusbar 在一个地方设置过后，整个app的statusbar状态都会改变，所以返回页面后需要恢复到该页面的配置。
    return Scaffold(
      body: _getMainList(),
    );
  }

  _getMainList() {
    List<MainPageItemModel> items = _mainPageModel?.itemData ?? List();
    print('重新执行');
    return Stack(
      children: <Widget>[
        Offstage(
          offstage: !_isLoading,
          child: Center(
            child: DialogUtils.getSpinKit(Colors.green),
          ),
        ),
        Offstage(
          offstage: _isLoading || !_isNotEmpty,
          child: _buildRefreshListView(_getListView(items)),
        ),
        Offstage(
          offstage: _isNotEmpty,
          child: getEmptyWidget(),
        ),
        Opacity(
          opacity: _searchTitleOpacity,
          child: Container(
            height: 56 + MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(
                color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3)]),
          ),
        ),
        _getSearchTitle(),
      ],
    );
//    }
  }

  Widget getEmptyWidget() {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.info_outline,
            size: 80,
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          Text('没有任何数据哦~'),
        ],
      ),
    );
  }

  _buildRefreshListView(getListView) {
    return RefreshIndicator(
      child: getListView,
      notificationPredicate: (ScrollNotification notification) {
        if (0 == notification.depth) {
          //只捕获最外层ListView的滑动数据
          double pix = notification.metrics.pixels / 150;
          if (pix > 1) {
            pix = 1;
          } else if (pix < 0) {
            pix = 0;
          }
          setState(() {
            _searchTitleOpacity = pix;
          });
        }
        return true;
      },
      onRefresh: initData,
    );
  }

  _getListView(List<MainPageItemModel> items) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) {
          Widget widget;
          MainPageItemModel mainPageItemModel = items[index];
          switch (mainPageItemModel?.itemType) {
            case "normal": //正常条目
              break;
            case "title": //标题类型 todo- 考虑把标题数据移到对应的条目中
              break;
            case "banner":
              widget = getSwiper(mainPageItemModel);
              break;
            case "horizontalListView":
              break;
            case "dynamicButtons":
              widget = _getDynamicButton(mainPageItemModel);
              break;
            case "webItem":
              widget = _getNormalItem(mainPageItemModel);
              break;
            case "tips":
              break;
          }
          return widget;
        },
        itemCount: items.length,
      ),
    );
  }

  getSwiper(MainPageItemModel mainPageItemModel) {
    final List<MainCommonModel> banners = mainPageItemModel?.normalDatas;
    return Container(
      height: 260,
      child: Swiper(
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: banners[index]?.imgUrl,
            fit: BoxFit.cover,
            placeholder: (BuildContext context, String url) {
              return Center(child: CircularProgressIndicator());
            },
          );
        },
        itemCount: banners.length,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey,
            activeColor: Colors.grey,
            activeSize: 8,
            size: 5,
          ),
        ),
        autoplay: true,
        scrollDirection: Axis.horizontal,
        onTap: (index) {
          Navigator.pushNamed(context, WebViewPage.routeName,
              arguments: WebViewArguments(banners[index]?.clickAction,
                  isHideTitle: true,
                  isHideStatus: false,
                  statusBarFontColor: Brightness.dark,
//                  titleColor: Color(banners[index]?.titleColor)));
                  titleColor: Colors.white));
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<void> initData() async {
    IApi api = FlowerApi();
    await api.getRequestForResults('js/a/app/api/index').then((data) {
      setState(() {
        _mainPageModel = MainPageModel.fromJsonMap(data);
        _isNotEmpty = _mainPageModel?.itemData != null ||
            _mainPageModel?.itemData?.length != 0;
        _isLoading = false;
      });
    });
  }

  _getNormalItem(MainPageItemModel mainPageItemModel) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, WebViewPage.routeName,
            arguments: WebViewArguments(mainPageItemModel?.clickAction,
                isHideTitle: true,
                isHideStatus: false,
                statusBarFontColor: Brightness.light,
                titleColor: Color(mainPageItemModel.titleColor)));
      },
      title: Text(
        mainPageItemModel?.title,
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
      subtitle: Text(
        mainPageItemModel?.subTitle,
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }

  _getDynamicButton(MainPageItemModel mainPageItemModel) {
    final screenWidth = ScreenUtils.getInstance().screenWidth;
    final List<MainCommonModel> datas = mainPageItemModel.normalDatas;
    var crossAxisCount = datas.length > 8 ? 5 : 4;
    return Container(
      margin: EdgeInsets.all(5),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),

          /// 禁止内部的gridView滑动，防止跟外部listView滑动冲突，从而导致在GridView上滑动时，滑动是失效的。
          itemCount: datas.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: CachedNetworkImage(
                        imageUrl: datas[index]?.imgUrl, fit: BoxFit.cover),
                  ),
                  Text(
                    datas[index]?.title,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }),
    );
  }

  ///返回顶部搜索组件
  _getSearchTitle() {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: SearchTitleBar(
        bgColor: Colors.transparent,
        leftWidget: SizedBox(
          width: 20,
        ),
        rightWidget: SizedBox(
          width: 20,
        ),
        inputBgColor: Colors.white,
        inputBorderColor: Colors.grey,
        inputEnable: false,
        onChanged: (String result) {},
      ),
    );
  }
}
