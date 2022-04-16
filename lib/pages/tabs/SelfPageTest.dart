import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:fast_gbk/fast_gbk.dart';
import 'package:flutter/material.dart';
import 'package:hmgpapp/common/Color.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class SelfPageTest extends StatefulWidget {
  SelfPageTest({Key? key}) : super(key: key);

  @override
  State<SelfPageTest> createState() => _SelfPageTestState();
}

class _SelfPageTestState extends State<SelfPageTest> {
  List<List<String?>> _selfData = [[]];
  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;
  String gbkDecoder(List<int> responseBytes, RequestOptions options,
      ResponseBody responseBody) {
    String result = gbk.decode(responseBytes);
    return result;
  }

  @override
  void initState() {
    user.initData(100);
    super.initState();
    _getSelctData();
  }

  _getSelctData() async {
    // FormData formData = FormData.fromMap({
    //   "pid": widget.arguments['id'],
    // });
    BaseOptions options = BaseOptions();
    options.responseDecoder = gbkDecoder;
    Dio dio = new Dio(options);
    dio.options.headers["Referer"] = 'https://finance.sina.com.cn/';
    var api = 'http://hq.sinajs.cn/list=sh601688,sh601003,sh601001';
    var result = await dio.get(api);

    print(result.data);
    print("去你大爷");
    String sss = result.data;
    print("去你吗");
    List<String> list = sss.split(';');
    list.removeLast();
    print(list.length);
    List<List<String>> stockInfo = [];
    for (String value in list) {
      RegExp stock = new RegExp("var hq_str_sh([^}]+)=");
      var stockNumber = stock.firstMatch(value);
      var stockNumberOne = stockNumber!.group(1);
      var stockNumberOnes = stockNumberOne!.toLowerCase();
      RegExp r = new RegExp("\"([^}]+),\"");
      var rnum = r.firstMatch(value);
      var rnumber = rnum!.group(1);
      List<String> stockNumberTwo = rnumber!.split(',');
      stockNumberTwo.add(stockNumberOnes);
      stockInfo.add(stockNumberTwo);
    }
    stockInfo.add([]);
    print(stockInfo);
    setState(() {
      this._selfData = stockInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自选股"),
      ),
      body: _getBodyWidget(),
    );
  }

  Widget _getBodyWidget() {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 80,
        rightHandSideColumnWidth: 900,
        // tableHeight: 700,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: this._selfData.length - 1,
        elevation: 0.0,
        elevationColor: Colour.black,
        // rowSeparatorWidget: const Divider(
        //   //表格横线
        //   color: Colors.grey,
        //   height: 1.0,
        //   thickness: 0.0,
        // ),
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
        verticalScrollbarStyle: const ScrollbarStyle(
          thumbColor: Colors.yellow,
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        horizontalScrollbarStyle: const ScrollbarStyle(
          thumbColor: Colors.grey,
          isAlwaysShown: true,
          thickness: 1.5,
          radius: Radius.circular(5.0),
        ),
        enablePullToRefresh: true,
        refreshIndicator: const WaterDropHeader(),
        refreshIndicatorHeight: 10,
        onRefresh: () async {
          //Do sth
          await Future.delayed(const Duration(milliseconds: 500));
          _hdtRefreshController.refreshCompleted();
        },
        enablePullToLoadNewData: true,
        loadIndicator: const ClassicFooter(),
        onLoad: () async {
          //Do sth
          await Future.delayed(const Duration(milliseconds: 500));
          _hdtRefreshController.loadComplete();
        },
        htdRefreshController: _hdtRefreshController,
      ),
      height: MediaQuery.of(context).size.height,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      // TextButton(
      //   style: TextButton.styleFrom(
      //     padding: EdgeInsets.zero,
      //   ),
      //   child: _getTitleItemWidget(
      //       'Name' + (sortType == sortName ? (isAscending ? '↓' : '↑') : ''),
      //       100),
      //   onPressed: () {
      //     sortType = sortName;
      //     isAscending = !isAscending;
      //     user.sortName(isAscending);
      //     setState(() {});
      //   },
      // ),
      // TextButton(
      //   style: TextButton.styleFrom(
      //     padding: EdgeInsets.zero,
      //   ),
      //   child: _getTitleItemWidget(
      //       'Status' +
      //           (sortType == sortStatus ? (isAscending ? '↓' : '↑') : ''),
      //       100),
      //   onPressed: () {
      //     sortType = sortStatus;
      //     isAscending = !isAscending;
      //     user.sortStatus(isAscending);
      //     setState(() {});
      //   },
      // ),
      _getTitleItemWidget('编辑', 100),
      // ),
      _getTitleItemWidget('最新', 100),
      _getTitleItemWidget('涨幅', 100),
      _getTitleItemWidget('涨跌', 100),
      _getTitleItemWidget('成交量(手)', 100),
      _getTitleItemWidget('成交额(万元)', 100),
      _getTitleItemWidget('开盘', 100),
      _getTitleItemWidget('昨收', 100),
      _getTitleItemWidget('最高', 100),
      _getTitleItemWidget('最低', 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Color(0x66666666)))),
      child: Text(label,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 12,
          )),
      width: width,
      height: 32,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Color(0x66666666)))),
      child: Column(
        children: [
          Text(
            this._selfData[index][0]!.toString(),
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colour.black),
          ),
          Text(
            this._selfData[index][33]!.toString(),
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Color(0x99999999)),
          ),
        ],
      ),
      width: 100,
      height: 32,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    var zuixin = this._selfData[index][3]!.toString();
    var xianjia = double.parse(zuixin);
    var shoupan = double.parse(this._selfData[index][2]!.toString());
    var zhangfuColor = (xianjia - shoupan) / shoupan * 100;
    var zhangfu = ((xianjia - shoupan) / shoupan * 100).toStringAsFixed(2);
    var zhangdieColor = xianjia - shoupan;
    var zhangdie = (xianjia - shoupan).toStringAsFixed(2);
    var chengjiaoliang =
        (double.parse(this._selfData[index][8]!.toString()) / 100)
            .toStringAsFixed(0);
    var chengjiaoe =
        (double.parse(this._selfData[index][9]!.toString()) / 10000)
            .toStringAsFixed(0);
    var zuigaoColor =
        double.parse(this._selfData[index][4]!.toString()) - xianjia;
    var zuidiColor =
        double.parse(this._selfData[index][5]!.toString()) - xianjia;
    // var zhangfuColor;
    // if (zhangfunum > 0) {
    //   var zhangfuColor = Colors.red;
    // } else {
    //   var zhangfuColor = Colors.green;
    // }
    return Row(
      children: <Widget>[
        // Container(
        //   child: Row(
        //     children: <Widget>[
        //       Icon(
        //           user.userInfo[index].status
        //               ? Icons.notifications_off
        //               : Icons.notifications_active,
        //           color:
        //               user.userInfo[index].status ? Colors.red : Colors.green),
        //       Text(user.userInfo[index].status ? 'Disabled' : 'Active')
        //     ],
        //   ),
        //   width: 100,
        //   height: 52,
        //   padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        //   alignment: Alignment.centerLeft,
        // ),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Color(0x66666666)))),
          child: Text(
            zuixin.substring(0, zuixin.length - 1),
          ),
          width: 100,
          height: 32,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Color(0x66666666)))),
          child: Text(
            zhangfu,
            style:
                TextStyle(color: zhangfuColor > 0 ? Colors.red : Colors.green),
          ),
          width: 100,
          height: 32,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Color(0x66666666)))),
          child: Text(
            zhangdie,
            style:
                TextStyle(color: zhangdieColor > 0 ? Colors.red : Colors.green),
          ),
          width: 100,
          height: 32,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          //成交量
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Color(0x66666666)))),
          child: Text(chengjiaoliang),
          width: 100,
          height: 32,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          //成交额
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Color(0x66666666)))),
          child: Text(chengjiaoe),
          width: 100,
          height: 32,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          //开盘
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Color(0x66666666)))),
          child: Text(
            this._selfData[index][1]!.toString(),
            style:
                TextStyle(color: zhangdieColor > 0 ? Colors.red : Colors.green),
          ),
          width: 100,
          height: 32,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          //昨收
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Color(0x66666666)))),
          child: Text(
            this._selfData[index][2]!.toString(),
          ),
          width: 100,
          height: 32,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          //最高
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Color(0x66666666)))),
          child: Text(
            double.parse(this._selfData[index][4]!.toString())
                .toStringAsFixed(2),
            style:
                TextStyle(color: zuigaoColor > 0 ? Colors.red : Colors.green),
          ),
          width: 100,
          height: 32,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          //最低
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Color(0x66666666)))),
          child: Text(
            double.parse(this._selfData[index][5]!.toString())
                .toStringAsFixed(2),
            style: TextStyle(color: zuidiColor > 0 ? Colors.red : Colors.green),
          ),
          width: 100,
          height: 32,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}

User user = User();

class User {
  List<UserInfo> userInfo = [];

  void initData(int size) {
    for (int i = 0; i < size; i++) {
      userInfo.add(UserInfo(
          "User_$i", i % 3 == 0, '+001 9999 9999', '2019-01-01', 'N/A'));
    }
  }

  ///
  /// Single sort, sort Name's id
  void sortName(bool isAscending) {
    userInfo.sort((a, b) {
      int aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
      int bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
      return (aId - bId) * (isAscending ? 1 : -1);
    });
  }

  ///
  /// sort with Status and Name as the 2nd Sort
  void sortStatus(bool isAscending) {
    userInfo.sort((a, b) {
      if (a.status == b.status) {
        int aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
        int bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
        return (aId - bId);
      } else if (a.status) {
        return isAscending ? 1 : -1;
      } else {
        return isAscending ? -1 : 1;
      }
    });
  }
}

class UserInfo {
  String name;
  bool status;
  String phone;
  String registerDate;
  String terminationDate;

  UserInfo(this.name, this.status, this.phone, this.registerDate,
      this.terminationDate);
}
