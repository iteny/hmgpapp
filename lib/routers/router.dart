import 'package:flutter/material.dart';
import '../pages/CategoryContent.dart';
import '../pages/tabs.dart';
// import 'package:jdshop/pages/ProductContent.dart';
// import 'package:jdshop/pages/ProductList.dart';
// import 'package:jdshop/pages/Search.dart';

//配置路由
final routes = {
  '/': (context) => Tabs(),
  // '/search': (context) => SearchPage(),
  // '/productList': (context, {arguments}) =>
  //     ProductListPage(arguments: arguments),
  '/categoryContent': (context, {arguments}) =>
      CategoryContentPage(arguments: arguments),
};
//固定写法
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
