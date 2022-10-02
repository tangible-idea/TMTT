


import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:get/get.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/pages.dart';
import 'package:tmtt/src/constants/local_storage_keys.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:tmtt/src/util/my_navigator.dart';

import '../base/base_get_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}

class RegisterController extends BaseGetController {

  late final inputController = TextEditingController();

  @override
  void onInit() { }

  @override
  void onClose() { }

  void goToHome() {
    MyNav.pushReplacementNamed(
      pageName: PageName.home,
    );
  }


  void register() async {
    var userId = inputController.text;

    FlutterInsta flutterInsta = FlutterInsta();
    await flutterInsta.getProfileData(userId);
    Log.d(
        flutterInsta.username + '\n' +
            flutterInsta.followers + '\n' +
            flutterInsta.following + '\n' +
            flutterInsta.imgurl
    );

    var registerDocId = await FireStore.register(userId);
    await LocalStorage.put(Keys.userInstagramId, userId);
    await LocalStorage.put(Keys.userDocId, registerDocId);
    await LocalStorage.put(Keys.isLogin, true);

    Log.d('success register');
    MyNav.pushReplacementNamed(
      pageName: PageName.home,
    );
  }
}

