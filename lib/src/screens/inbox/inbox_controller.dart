
import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:get/get.dart';
import 'package:tmtt/data/model/hint.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/pages.dart';
import 'package:tmtt/src/constants/local_storage_keys.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:tmtt/src/util/my_navigator.dart';

import '../base/base_get_controller.dart';

class InboxBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InboxController());
  }
}

class InboxController extends BaseGetController {

  var messageObs = Message(hint: Hint()).obs;

  @override
  void onInit() {
    var message = Get.parameters['message'] as Message;
    messageObs.value = message;
    Log.d(message);
  }

  @override
  void onClose() { }



}

