

import 'package:flutter/material.dart';

import 'package:flutter_insta/flutter_insta.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_get_controller.dart';
import 'package:tmtt/src/util/my_logger.dart';


class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends BaseGetController {

  late final inputController = TextEditingController();

  var userNameObs = ''.obs;

  @override
  void onInit() {

  }

  @override
  void onClose() {

  }

  void searchInstaUser() async {
    String userName = inputController.text;
    Log.d(userName);

    FlutterInsta flutterInsta = FlutterInsta();
    await flutterInsta.getProfileData(userName); //instagram username
    String a = inputController.text;
    Log.d(a);
    userNameObs.value = flutterInsta.bio;

    Log.d(
      flutterInsta.username + '\n' +
      flutterInsta.followers + '\n' +
      flutterInsta.following + '\n' +
      flutterInsta.imgurl
    );
  }

  @override
  void onBackPressed() {

  }

  @override
  void onNextPressed() {

  }

}