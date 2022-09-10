
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

  @override
  void onInit() {

  }

  @override
  void onClose() {

  }

  void searchInstaUser() async {

    String a = inputController.text;
    FlutterInsta flutterInsta = FlutterInsta();
    await flutterInsta.getProfileData(a); //instagram username

    print("Username : ${flutterInsta.username}");
    print("Followers : ${flutterInsta.followers}");
    print("Folowing : ${flutterInsta.following}");
  }

  @override
  void onBackPressed() {

  }

  @override
  void onNextPressed() {

  }

}