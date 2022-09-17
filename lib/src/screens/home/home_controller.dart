
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

    String a = inputController.text;
    Log.d(a);
    FlutterInsta flutterInsta = FlutterInsta();
    await flutterInsta.getProfileData(a); //instagram username

    print("Username : ${flutterInsta.username}");
    print("Followers : ${flutterInsta.followers}");
    print("Folowing : ${flutterInsta.following}");

    userNameObs.value = flutterInsta.bio;


    /// 1. parse a document String
    // BeautifulSoup bs = BeautifulSoup("https://www.instagram.com/$a");
    // print(bs.body);
    // var found= bs.find('profile_pic_url_hd');
    // print(found);
// use BeautifulSoup.fragment(html_doc_string) if you parse a part of html
  }

  @override
  void onBackPressed() {

  }

  @override
  void onNextPressed() {

  }

}