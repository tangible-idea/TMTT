
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/data/model/user.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/src/screens/base/base_get_controller.dart';
import 'package:tmtt/src/util/info_util.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:tmtt/src/util/my_snackbar.dart';

class WriteMessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WriteMessageController());
  }
}

class WriteMessageController extends BaseGetController {

  @override
  void onInit() {
    Log.d('onInit WriteMessageController');
    // getUserId();
  }

  late final inputController = TextEditingController();

  var userNameObs = ''.obs;
  var currentUserId = '';
  var currentUser = User();

  Future<void> getUserId() async {
    InfoUtil.getAllDeviceInfo();

    String userName = Get.parameters['uid'] ?? '';
    currentUserId = userName;
    var user = await FireStore.searchUser(userName);
    if (user == null) {
      userNameObs.value = 'not found user id';
      return;
    }
    currentUser = user;
    userNameObs.value = ""
        "found user id: ${user.userId}\n"
        "message: ${user.message}";
  }

  Future<void> writeMessage() async {
    String message = inputController.text;
    if(message.isEmpty) { return; }

    FireStore.writeMessage(
        user: currentUser,
        message: message,
        emojiCode: 0
    );

    MySnackBar.show(title: 'send success!');
  }

  @override
  void onClose() {
    Log.d('onClose WriteMessageController');
    inputController.dispose();
  }

}