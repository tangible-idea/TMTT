

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_insta/flutter_insta.dart';
import 'package:flutter_social_content_share/flutter_social_content_share.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_get_controller.dart';
import 'package:tmtt/src/screens/home/home_fragment.dart';
import 'package:tmtt/src/screens/home/inbox_fragment.dart';
import 'package:tmtt/src/screens/home/setting_fragment.dart';
import 'package:tmtt/src/util/my_logger.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends BaseGetController {

  @override
  void onInit() {

  }

  @override
  void onClose() {

  }

  var currentIndexObs = 0.obs;

  List<Widget> pages = [
    HomeFragment(),
    InboxFragment(),
    SettingFragment(),
  ];

  List<String> pageTitles = [
    'home',
    'inbox',
    'setting',
  ];

  late final inputController = TextEditingController();

  var userNameObs = ''.obs;
  
  static const shareInstaChannel= MethodChannel("link.tmtt/shareinsta");

  // 인스타에 공유하기
  Future<void> shareOnInstagram(BuildContext context) async {

    final arguments= "test";
    final String resultFromAndroid= await shareInstaChannel.invokeMethod("sharePhotoToInstagram", arguments);
    //Log.d(resultFromAndroid);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultFromAndroid)));
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

  void registerUser() {

  }

  @override
  void onBackPressed() {

  }

  @override
  void onNextPressed() {

  }

}