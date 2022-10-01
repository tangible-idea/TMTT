

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/util/info_util.dart';

import 'base/base_get_controller.dart';

class IndexBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexController());
  }
}

class IndexController extends BaseGetController {

  var infoObs = ''.obs;

  @override
  void onInit() { }

  @override
  void onClose() { }

  void getDeviceInfoTest() async {
    infoObs.value = await InfoUtil.getAllDeviceInfo();
  }

}

