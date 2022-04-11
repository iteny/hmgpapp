import 'package:dio/dio.dart';
import 'package:fast_gbk/fast_gbk.dart';
import 'package:flutter/material.dart';
import '../../common/ScreenAdapter.dart';

class SelfPage extends StatefulWidget {
  SelfPage({Key? key}) : super(key: key);

  @override
  State<SelfPage> createState() => _SelfPageState();
}

class _SelfPageState extends State<SelfPage> {
  List<List<String?>> _selfData = [[]];

  // ResponseDecoder? get gbkDecoder => null;
  String gbkDecoder(List<int> responseBytes, RequestOptions options,
      ResponseBody responseBody) {
    String result = gbk.decode(responseBytes);
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
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
    // print(list);
    // print(list is List);
    // print(list.length);
    list.removeLast();
    print(list.length);
    List<String?> stocks = [];
    List<List<String?>> stockInfo = [];
    for (String value in list) {
      // print("我得名字${value}");
      RegExp stock = new RegExp("var hq_str_sh([^}]+)=");
      var stockNumber = stock.firstMatch(value);
      print(stockNumber!.group(1));
      var stockNumberOne = stockNumber.group(1);
      RegExp r = new RegExp("\"([^}]+)\"");
      var rnum = r.firstMatch(value);
      print(rnum?.group(1));
      var rnumber = rnum!.group(1);
      print(rnumber is String);
      List<String> stockNumberTwo = rnumber!.split(',');
      stocks.add(stockNumberOne);
      stocks.addAll(stockNumberTwo);
      stockInfo.add(stocks);
    }
    print(stockInfo);
    // var categoryContentData = CategoryContentModel.fromJson(result.data);
    // print(categoryContentData.result);
    // print(categoryContentData.data);
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
      body: Container(
        width: ScreenAdapter.width(400),

        // height: ScreenAdapter.width(111400),
        child: ListView.builder(
          shrinkWrap: true,
          // scrollDirection: Axis.horizontal,
          itemBuilder: (contxt, index) {
            return Column(
              children: [Text(this._selfData[index][0].toString())],
            );
          },
          itemCount: this._selfData.length,
        ),
      ),
    );
  }
}
