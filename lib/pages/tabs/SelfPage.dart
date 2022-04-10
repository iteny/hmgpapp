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
  List _selfData = [];

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
    // List<int> gbkCodes = gbk.encode(result.data);
    // String hex = '';
    // gbkCodes.forEach((i) {
    //   hex += i.toRadixString(16) + ' ';
    // });
    // print(hex);
    // print(gbk.decode(gbkCodes));
    // List<int> gbk_byteCodes = gbk_bytes.encode(result.data);
    // hex = '';
    // gbk_byteCodes.forEach((i) {
    //   hex += i.toRadixString(16) + ' ';
    // });
    // print(hex);

    // //gbk_bytes decode
    // String decoded_bytes_text = gbk_bytes.decode(gbk_byteCodes);
    // print(decoded_bytes_text);
    String sss = result.data;
    // var encoded = gbk.encode(result.data);
    // var decoded = gbk.decode(encoded);
    // print(decoded);
    print("去你吗");
    List<String> list = sss.split(';');
    print(list);
    print(list is List);
    print(list.length);
    // var categoryContentData = CategoryContentModel.fromJson(result.data);
    // print(categoryContentData.result);
    // print(categoryContentData.data);
    setState(() {
      this._selfData = list;
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
              children: [
                Text(this._selfData[index]),
              ],
            );
          },
          itemCount: this._selfData.length,
        ),
      ),
    );
  }
}
