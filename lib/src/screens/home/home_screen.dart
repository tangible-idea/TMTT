
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';


class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('home!'),
          Text('home!'),
          Text('home!'),
          Text('home!'),
          Text('home!'),
        ],
      ),
    );
  }
}


