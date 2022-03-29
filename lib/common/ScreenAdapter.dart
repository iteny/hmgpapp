import 'package:flutter_screenutil/flutter_screenutil.dart';

//屏幕适配
class ScreenAdapter {
  // static init(context) {
  //   ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
  // }

  static height(num value) {
    return ScreenUtil().setHeight(value);
  }

  static width(num value) {
    return ScreenUtil().setWidth(value);
  }

  static size(num value) {
    return ScreenUtil().setSp(value);
  }

  static getHeight() {
    return ScreenUtil().screenHeight; //获取设备高度
  }

  static getWidth() {
    return ScreenUtil().screenWidth; //获取设备宽度
  }
}
