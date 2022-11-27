

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_get_controller.dart';
import 'info_util.dart';
import 'my_logger.dart';

class IndexBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexController());
  }
}

class IndexController extends BaseGetController {

  var infoObs = ''.obs;
  var instaInfoObs = ''.obs;
  var instaProfilePictureObs = ''.obs;

  @override
  void onInit() { }

  @override
  void onClose() { }

  void getDeviceInfoTest() async {
    var info = await InfoUtil.getAllDeviceInfo();
    Log.d(info);
    infoObs.value = info;


    // var instaInfo = await InfoUtil.getInstagramInfo('hunkim_food');
    // Log.d(instaInfo);
    // instaInfoObs.value =
    // 'fullName: ${instaInfo.graphql?.user?.fullName ?? ''}\n'
    //     'biography: ${instaInfo.graphql?.user?.biography ?? ''}';
    // instaProfilePictureObs.value = instaInfo.graphql?.user?.profilePicUrl ?? '';
  }

}

