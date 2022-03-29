import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hmgpapp/model/CategoryModel.dart';
import '../../config/Config.dart';
import '../../common/Color.dart';
import '../../common/Icons.dart';
import '../../common/ScreenAdapter.dart';
import '../../widget/IconsButton.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _hotProductList = [];
  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  //获取分类
  _getCategory() async {
    var api = '${Config.domain}gpapp/getCategory';
    var result = await Dio().post(api);
    var hotProductList = CategoryModel.fromJson(result.data);
    hotProductList.data?.forEach((data) {
      print(data.name);
      print(data.url);
    });
    setState(() {
      this._hotProductList = hotProductList.data!;
    });
  }

  _getContent() {
    var itemWidth = (ScreenAdapter.getWidth() - 60.0) / 4;
    print(itemWidth);
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10, //中间的间距10
        spacing: 10,
        children: [
          InkWell(
            child: Container(
              width: itemWidth,
              child: Column(
                children: [Icon(Icons.add), Text("asdfads")],
              ),
            ),
          ),
          InkWell(
            child: Container(
              width: itemWidth,
              child: Column(
                children: [Icon(Icons.add), Text("asdfads")],
              ),
            ),
          ),
          InkWell(
            child: Container(
              width: itemWidth,
              child: Column(
                children: [Icon(Icons.add), Text("asdfads")],
              ),
            ),
          ),
          InkWell(
            child: Container(
              width: itemWidth,
              child: Column(
                children: [Icon(Icons.add), Text("asdfads")],
              ),
            ),
          ),
          InkWell(
            child: Container(
              width: itemWidth,
              child: Column(
                children: [Icon(Icons.add), Text("asdfads")],
              ),
            ),
          ),
          InkWell(
            child: Container(
              width: itemWidth,
              child: Column(
                children: [Icon(Icons.add), Text("asdfads")],
              ),
            ),
          ),
          InkWell(
            child: Container(
              width: itemWidth,
              child: Column(
                children: [Icon(Icons.add), Text("asdfads")],
              ),
            ),
          ),
          InkWell(
            child: Container(
              width: itemWidth,
              child: Column(
                children: [Icon(Icons.add), Text("asdfads")],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Colour.green, Colors.blueAccent],
            ),
          ),
        ),
        toolbarHeight: ScreenAdapter.height(100),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Icon(Iconme.username),
                  IconsButton(
                    color: Colour.white,
                    click: () {
                      print("用户");
                    },
                    icon: Iconme.username,
                  ),
                  IconsButton(
                    color: Colour.white,
                    click: () {
                      print("邮箱");
                    },
                    icon: Iconme.email,
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Icon(Iconme.scan),
                  // Icon(Iconme.moneyManagement),
                  // Icon(Iconme.search),
                  IconsButton(
                    color: Colour.white,
                    click: () {
                      print("扫一扫");
                    },
                    icon: Iconme.scan,
                  ),
                  IconsButton(
                    color: Colour.white,
                    click: () {
                      print("理财");
                    },
                    icon: Iconme.moneyManagement,
                  ),
                  IconsButton(
                    color: Colour.white,
                    click: () {
                      print("搜索");
                    },
                    icon: Iconme.search,
                    space: 0.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          _getContent(),
        ],
      ),
    );
  }
}
