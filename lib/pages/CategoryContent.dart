import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hmgpapp/common/ScreenAdapter.dart';
import '../model/CategoryContentModel.dart';
import '../config/Config.dart';

class CategoryContentPage extends StatefulWidget {
  final Map arguments;
  CategoryContentPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<CategoryContentPage> createState() => _CategoryContentPageState();
}

class _CategoryContentPageState extends State<CategoryContentPage> {
  List _categoryContentData = [];
  @override
  void initState() {
    super.initState();
    _getCategoryContent();
  }

  _getCategoryContent() async {
    FormData formData = FormData.fromMap({
      "pid": widget.arguments['id'],
    });
    var api = '${Config.domain}gpapp/getCategoryContent';
    var result = await Dio().post(api, data: formData);
    print(result.data);
    var categoryContentData = CategoryContentModel.fromJson(result.data);
    // print(categoryContentData.result);
    // print(categoryContentData.data);
    setState(() {
      this._categoryContentData = categoryContentData.data!;
    });
  }

  Widget _categoryContent() {
    if (this._categoryContentData.length > 0) {
      return Container(
        width: ScreenAdapter.width(400),
        height: ScreenAdapter.width(400),
        child: ListView.builder(
          scrollDirection: Axis.horizontal, //listview修改成水平列表
          itemBuilder: (contxt, index) {
            return Column(
              children: <Widget>[
                Text(this._categoryContentData[index].title),
                Text(this._categoryContentData[index].content)
              ],
            );
          },
          itemCount: this._categoryContentData.length,
        ),
      );
    } else {
      return Text("没有");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("你好"),
      ),
      body: ListView(
        children: [
          _categoryContent(),
        ],
      ),
    );
  }
}
