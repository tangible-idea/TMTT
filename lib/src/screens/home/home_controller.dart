
import 'package:flutter/material.dart';
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

  String getInputValue() {
    return inputController.text;
  }

  @override
  void onBackPressed() {

  }

  @override
  void onNextPressed() {

  }

}