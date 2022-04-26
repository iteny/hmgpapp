import 'package:flutter/material.dart';
import '../pages/tabs/SelfPage.dart';
import '../pages/tabs/SelfPageTest.dart';
import '../common/Storage.dart';
import '../pages/tabs/HomePage.dart';
import '../common/Icons.dart';
import '../common/Color.dart';
import '../common/ScreenAdapter.dart';
// import 'package:jdshop/common/ScreenAdaper.dart';
// import 'package:jdshop/pages/tabs/Cart.dart';
// import 'package:jdshop/pages/tabs/Category.dart';
// import 'package:jdshop/pages/tabs/HomePage.dart';
// import 'package:jdshop/pages/tabs/User.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tabs extends StatefulWidget {
  Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    this._pageController = new PageController(initialPage: this._currentIndex);
  }

  List<Widget> _pageList = [
    HomePage(),
    SelfPageTest(),
    SelfPage(),
    // SelfPageTest(),
    // CartPage(),
    // UserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
      designSize: Size(1080, 1920),
      context: context,
    );
    return Scaffold(
      // appBar: AppBar(
      //   title: InkWell(
      //     child: Container(
      //       height: ScreenAdapter.height(70),
      //       padding: EdgeInsets.only(left: 10),
      //       decoration: BoxDecoration(
      //           color: Colorme.gray, borderRadius: BorderRadius.circular(30)),
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.center, //行里面元素上下居中
      //         children: [
      //           Icon(Icons.search),
      //           Text(
      //             "笔记本",
      //             style: TextStyle(fontSize: ScreenAdapter.size(28)),
      //           ),
      //         ],
      //       ),
      //     ),
      //     onTap: () {
      //       Navigator.pushNamed(context, "/search");
      //     },
      //   ),
      //   leading: IconButton(
      //     icon: Icon(Icons.center_focus_weak),
      //     onPressed: null,
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: Icon(
      //         Icons.message,
      //         size: 28,
      //         color: Colorme.black,
      //       ),
      //       onPressed: null,
      //     ),
      //   ],
      // ),
      body: PageView(
        controller: this._pageController,
        children: this._pageList,
        onPageChanged: (index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        physics: NeverScrollableScrollPhysics(), //禁用tab左右滑动切换
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
            // 跳转页面
            this._pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed, //多个菜单显示的问题
        fixedColor: Colour.red, //tabs选中时的颜色
        items: [
          BottomNavigationBarItem(
            icon: Icon(Iconme.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconme.food),
            label: '自选测试',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconme.record),
            label: '自选',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconme.accound),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
