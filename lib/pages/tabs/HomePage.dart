import 'dart:convert';

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
  List _categoryList = [];
  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  //获取分类
  _getCategory() async {
    var api = '${Config.domain}gpapp/getCategory';
    var result = await Dio().post(api);
    // print(result.data is Map);
    var categoryList = CategoryModel.fromJson(result.data);
    // categoryList.data?.forEach((value) {
    //   print(value.name);
    //   print(value.url);
    // });
    setState(() {
      this._categoryList = categoryList.data!;
    });
  }

  Widget _getContent() {
    var itemWidth = (ScreenAdapter.getWidth() - 50.0) / 4;
    print(itemWidth);
    if (this._categoryList.length > 0) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 10, //中间的间距10
          spacing: 10,
          children: this._categoryList.map((value) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/productContent',
                    arguments: {"id": value.sId});
              },
              child: Container(
                width: itemWidth,
                child: Column(
                  children: [
                    Icon(
                      IconData(int.parse(value.icon), fontFamily: 'iconfont'),
                    ),
                    Text("${value.name}")
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );

      // child: Wrap(
      //   runSpacing: 10, //中间的间距10
      //   spacing: 10,
      //   children: [
      //     InkWell(
      //       child: Container(
      //         width: itemWidth,
      //         child: Column(
      //           children: [Icon(Icons.add), Text("asdfads")],
      //         ),
      //       ),
      //     ),
      //     InkWell(
      //       child: Container(
      //         width: itemWidth,
      //         child: Column(
      //           children: [Icon(Icons.add), Text("asdfads")],
      //         ),
      //       ),
      //     ),
      //     InkWell(
      //       child: Container(
      //         width: itemWidth,
      //         child: Column(
      //           children: [Icon(Icons.add), Text("asdfads")],
      //         ),
      //       ),
      //     ),
      //     InkWell(
      //       child: Container(
      //         width: itemWidth,
      //         child: Column(
      //           children: [Icon(Icons.add), Text("asdfads")],
      //         ),
      //       ),
      //     ),
      //     InkWell(
      //       child: Container(
      //         width: itemWidth,
      //         child: Column(
      //           children: [Icon(Icons.add), Text("asdfads")],
      //         ),
      //       ),
      //     ),
      //     InkWell(
      //       child: Container(
      //         width: itemWidth,
      //         child: Column(
      //           children: [Icon(Icons.add), Text("asdfads")],
      //         ),
      //       ),
      //     ),
      //     InkWell(
      //       child: Container(
      //         width: itemWidth,
      //         child: Column(
      //           children: [Icon(Icons.add), Text("asdfads")],
      //         ),
      //       ),
      //     ),
      //     InkWell(
      //       child: Container(
      //         width: itemWidth,
      //         child: Column(
      //           children: [Icon(Icons.add), Text("asdfads")],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    } else {
      return Text("加载中");
    }
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
