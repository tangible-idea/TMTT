
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

    String userName = inputController.text;
    Log.d(userName);

    FlutterInsta flutterInsta = FlutterInsta();
    await flutterInsta.getProfileData(userName); //instagram username
    String a = inputController.text;
    Log.d(a);

    print("Username : ${flutterInsta.username}");
    print("Followers : ${flutterInsta.followers}");
    print("Folowing : ${flutterInsta.following}");
    print("imgurl : ${flutterInsta.imgurl}");
    print("Username : ${flutterInsta.username}");
    print("Followers : ${flutterInsta.followers}");
    print("Folowing : ${flutterInsta.following}");

    userNameObs.value = flutterInsta.bio;
    // String url = "https://www.instagram.com/$userName";
    // String fullUrl = "$url/?__a=1&_a_d=dis";
    // Log.d(fullUrl);
    //
    // var res = await http.get(Uri.parse(Uri.encodeFull(fullUrl)));
    //
    // Log.d(res);
    // Log.d(res.body);
    //
    // Log.d(json.decode(res.body));


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