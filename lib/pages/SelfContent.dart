import 'package:flutter/material.dart';

class SelfContent extends StatefulWidget {
  final Map arguments;
  SelfContent({Key? key, required this.arguments}) : super(key: key);

  @override
  State<SelfContent> createState() => _SelfContentState();
}

class _SelfContentState extends State<SelfContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("${widget.arguments['stockCode']}"),
    );
  }
}
