import 'package:flutter/material.dart';
import '../common/Color.dart';
import '../common/ScreenAdapter.dart';

class TextsButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function()? click;
  TextsButton({
    Key? key,
    required this.color,
    this.text = "按钮",
    this.click, //注意：新版Flutter中需要把cb定义成Function()类型或者var类型
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Container(
        margin: EdgeInsets.only(left: 5, top: 0, bottom: 0),
        padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
        height: ScreenAdapter.height(58),
        // width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            "${text}",
            style: TextStyle(color: Colour.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
