

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_insta/flutter_insta.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tmtt/data/model/user.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/src/constants/URLs.dart';
import 'package:tmtt/src/screens/base/base_get_controller.dart';
import 'package:tmtt/src/screens/home/home_fragment.dart';
import 'package:tmtt/src/screens/home/inbox_fragment.dart';
import 'package:tmtt/src/screens/home/setting_fragment.dart';
import 'package:tmtt/src/util/info_util.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:flutter/services.dart';

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
    inputController.dispose();
    messageInputController.dispose();
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

  ImagePicker imagePicker = ImagePicker();
  PickedFile? backgroundVideo;
  PickedFile? stickerImage;

  late final inputController = TextEditingController();
  late final messageInputController = TextEditingController();

  var userNameObs = ''.obs;
  var deviceInfoObs = ''.obs;
  var myInfoObs = User().obs;
  var myLinkObs = ''.obs;

  static const shareInstaChannel= MethodChannel("link.tmtt/shareinsta");

  // 인스타에 공유하기
  Future<void> shareOnInstagram(BuildContext context) async {

    // backgroundVideo = await imagePicker.getVideo(
    //   source: ImageSource.gallery,
    // );
    stickerImage = await imagePicker.getImage(
      source: ImageSource.gallery,
    );


    Map<String, dynamic> arguments = {
      "imagePath": stickerImage!.path
    };
    //final String resultFromAndroid= await shareInstaChannel.invokeMethod("sharePhotoToInstagram", arguments);

    final String resultFromAndroid= await shareInstaChannel.invokeMethod("shareInstagramImageStoryWithSticker", arguments);
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

  Future<void> getMyInfo() async {
    var myInfo = await FireStore.getMyInfo();
    if (myInfo == null) { return; }
    messageInputController.text = myInfo.message;
    userNameObs.value = myInfo.userId;
    myLinkObs.value = '${Urls.baseUrl}#/${myInfo.userId}';
    myInfoObs.value = myInfo;
  }

  Future<void> editMyMessage() async {
    var text = messageInputController.text;
    if(text.isEmpty) { return; }
    await FireStore.editMyMessage(text);
    Get.snackbar("edit success!", "");
    myInfoObs.value.message = text;
  }

  Future<void> copyMyLink() async {
    Clipboard.setData(ClipboardData(text: myLinkObs.value));
    Get.snackbar("copy success!", "");
  }

  void getDeviceInfoTest() async {
    deviceInfoObs.value = await InfoUtil.getAllDeviceInfo();
  }

  // void getMyProfile() {
  //
  //   FireStore.getMyInfo();
  //
  //   myInfoObs;
  // }


  void registerUser() {

  }

  @override
  void onBackPressed() {

  }

  @override
  void onNextPressed() {

  }

}