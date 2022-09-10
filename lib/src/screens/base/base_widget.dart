
import 'package:flutter/material.dart';

abstract class BaseWidget extends StatefulWidget {

  void onInit();
  Widget onBuild(BuildContext context);

  BaseWidget({Key? key}) : super(key: key);

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.onBuild(context);
  }
}
