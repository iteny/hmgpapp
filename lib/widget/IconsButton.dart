import 'package:flutter/material.dart';
import '../../common/Icons.dart';
import '../common/Color.dart';
import '../common/ScreenAdapter.dart';

class IconsButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Function()? click;
  final double space;
  IconsButton({
    Key? key,
    required this.color,
    this.icon = Iconme.accound,
    this.space = 10,
    this.click, //注意：新版Flutter中需要把cb定义成Function()类型或者var类型
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Container(
        margin: EdgeInsets.only(right: space),
        // padding: EdgeInsets.all(5),
        // height: ScreenAdapter.width(64),
        // width: double.infinity,
        decoration: BoxDecoration(
          // color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(
            icon,
            color: color,
          ),
        ),
      ),
    );
  }
}
