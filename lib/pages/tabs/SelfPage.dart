import 'dart:async';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:fast_gbk/fast_gbk.dart';
import 'package:flutter/material.dart';
import '../../common/Icons.dart';
import '../../model/SelfSelectModel.dart';
import '../../widget/IconsButton.dart';
import '../../widget/TextsButton.dart';
import '../../common/Color.dart';
import '../../config/Config.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class SelfPage extends StatefulWidget {
  SelfPage({Key? key}) : super(key: key);

  @override
  State<SelfPage> createState() => _SelfPageState();
}

class _SelfPageState extends State<SelfPage> {
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

  late Timer _timer;
  @override
  void initState() {
    // user.initData(100);
    _timer = Timer.periodic(Duration(seconds: 10), (_) => _getSelctData());
    super.initState();
    _getSelctData();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _getSelctData() async {
    // FormData formData = FormData.fromMap({
    //   "pid": widget.arguments['id'],
    // });
    var selfApi = '${Config.domain}gpapp/getSelfSelect';
    var selefResult = await Dio().post(selfApi);
    var selfSelectList = SelfSelectModel.fromJson(selefResult.data);
    var selfSelectString = "";
    selfSelectList.data?.forEach((value) {
      selfSelectString =
          selfSelectString + "${value.sector}" + "${value.code}" + ",";
    });
    var selfCode = selfSelectString.substring(0, selfSelectString.length - 1);
    print(selfCode);
    //下面是股票数据
    BaseOptions options = BaseOptions();
    options.responseDecoder = gbkDecoder;
    Dio dio = new Dio(options);
    dio.options.headers["Referer"] = 'https://finance.sina.com.cn/';
    var api = 'http://hq.sinajs.cn/list=' + selfCode;
    var result = await dio.get(api);

    print(result.data);
    print("去你大爷");
    String sss = result.data;
    print("去你吗");
    List<String> list = sss.split(';');
    list.removeLast();
    print(list.length);
    List<List<String>> stockInfo = [];
    List<String> stocknew = [];
    for (String value in list) {
      RegExp stock = RegExp("var hq_str_s[hz]([^}]+)=");
      // RegExp stocksss = new RegExp("var hq_str_sz([^}]+)=");

      var stockNumber = stock.firstMatch(value);
      // var stockNumbersss = stocksss.firstMatch(value);
      var stockNumberOne = stockNumber!.group(1);
      print("好好好好");
      print(stockNumberOne);
      // if (stockNumber!.group(1) == null) {}
      var stockNumberOnes = stockNumberOne!.toLowerCase();
      print(stockNumberOnes);

      // var rrrr = find(value);
      // print(rrrr);
      RegExp r =
          RegExp("var hq_str_s[hz][0-9][0-9][0-9][0-9][0-9][0-9]=\"([^}]+)\"");
      var rnum = r.firstMatch(value);
      var rnumber = rnum!.group(1);
      print(rnumber);
      var rnumbers = rnumber?.toLowerCase();
      print(rnumbers);
      List<String> stockNumberTwo = rnumbers!.split(',');
      stockNumberTwo.insert(0, stockNumberOnes);
      stockInfo.add(stockNumberTwo);
    }
    stockInfo.add([]);
    print("是吗");
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
        enablePullToRefresh: false,
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
            this._selfData[index][1]!.toString(),
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colour.black),
          ),
          Text(
            this._selfData[index][0]!.toString(),
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
    var zuixin = this._selfData[index][4]!.toString();
    var xianjia = double.parse(zuixin);
    var shoupan = double.parse(this._selfData[index][3]!.toString());
    var zhangfuColor = (xianjia - shoupan) / shoupan * 100;
    var zhangfu = ((xianjia - shoupan) / shoupan * 100).toStringAsFixed(2);
    var zhangdieColor = xianjia - shoupan;
    var zhangdie = (xianjia - shoupan).toStringAsFixed(2);
    var chengjiaoliang =
        (double.parse(this._selfData[index][9]!.toString()) / 100)
            .toStringAsFixed(0);
    var chengjiaoe =
        (double.parse(this._selfData[index][10]!.toString()) / 10000)
            .toStringAsFixed(0);
    var zuigaoColor =
        double.parse(this._selfData[index][5]!.toString()) - xianjia;
    var zuidiColor =
        double.parse(this._selfData[index][6]!.toString()) - xianjia;
    // var zhangfuColor;
    // if (zhangfunum > 0) {
    //   var zhangfuColor = Colors.red;
    // } else {
    //   var zhangfuColor = Colors.green;
    // }
    var stockCode = this._selfData[index][0]!.toString();
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
          child: Row(
            children: [
              Text(
                zuixin.substring(0, zuixin.length - 1),
              ),
              TextsButton(
                color: Colour.blue,
                text: "详情",
                click: () {
                  Navigator.pushNamed(context, '/selfContent',
                      arguments: {"stockCode": stockCode});
                },
              ),
            ],
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
            this._selfData[index][2]!.toString(),
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
            this._selfData[index][3]!.toString(),
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
            double.parse(this._selfData[index][5]!.toString())
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
            double.parse(this._selfData[index][6]!.toString())
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
