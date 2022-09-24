
import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_get_controller.dart';
import 'package:tmtt/src/util/my_logger.dart';

class ShareBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShareController());
  }
}

class ShareController extends BaseGetController {

  late final inputController = TextEditingController();

  var textToShare = ''.obs;

  void shareOnInstagram() {

  }

  @override
  void onInit() {

  }

  @override
  void onClose() {

  }

  @override
  void onBackPressed() {

  }

  @override
  void onNextPressed() {

  }

}