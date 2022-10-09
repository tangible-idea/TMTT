
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_insta/flutter_insta.dart';
import 'package:get/get.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/data/model/user.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/pages.dart';
import 'package:tmtt/src/constants/URLs.dart';
import 'package:tmtt/src/screens/base/base_get_controller.dart';
import 'package:tmtt/src/screens/home/home_fragment.dart';
import 'package:tmtt/src/screens/home/inbox_fragment.dart';
import 'package:tmtt/src/screens/home/setting_fragment.dart';
import 'package:tmtt/src/util/info_util.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:tmtt/src/util/my_navigator.dart';
import 'package:tmtt/src/util/my_snackbar.dart';
import 'package:tmtt/src/util/posting_helper.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends BaseGetController {

  @override
  void onInit() {
    getMyInfo();
    getInsta();
  }

  void getInsta() async {
    var instaInfo = await InfoUtil.getInstagramInfo('hunkim_food');
    Log.d(instaInfo);
  }

  @override
  void onClose() {
    inputController.dispose();
    messageInputController.dispose();
  }

  /// tab navigation

  var currentPageIndexObs = 0.obs;
  List<Widget> pages = [ HomeFragment(), InboxFragment(), SettingFragment() ];
  List<String> pageTitles = [ 'tmtt', 'inbox', 'other', ];

  /// ========================================================

  late final inputController = TextEditingController();
  late final messageInputController = TextEditingController();

  /// ========================================================

  var userNameObs = ''.obs;
  var deviceInfoObs = ''.obs;
  var myInfoObs = User().obs;
  var myLinkObs = ''.obs;
  var messagesObs = <Message>[].obs;

  void searchInstaUser() async {
    String userName = inputController.text;
    FlutterInsta flutterInsta = FlutterInsta();
    await flutterInsta.getProfileData(userName); //instagram username
    userNameObs.value = flutterInsta.bio;
    Log.d(
      flutterInsta.username + '\n' +
      flutterInsta.followers + '\n' +
      flutterInsta.following + '\n' +
      flutterInsta.imgurl
    );
  }

  /// tmtt page

  Future<void> getMyInfo() async {
    var myInfo = await FireStore.getMyInfo();
    if (myInfo == null) { return; }
    messageInputController.text = myInfo.message;
    userNameObs.value = myInfo.userId;
    myLinkObs.value = '${MyUrl.baseUrl}#/${myInfo.userId}';
    myInfoObs.value = myInfo;
  }

  Future<void> copyMyLink() async {
    Clipboard.setData(ClipboardData(text: myLinkObs.value));
    MySnackBar.show(title: 'copy success!');
  }

  Future<void> editMyStateMessage() async {
    var text = messageInputController.text;
    if(text.isEmpty) { return; }
    await FireStore.editMySateMessage(text);
    MySnackBar.show(title: 'edit success!');
    myInfoObs.value.message = text;
  }

  // 인스타에 공유하기
  Future<void> shareOnInstagram(BuildContext context) async {
    var message = messageInputController.text;
    var result = await PostingHelper.shareOnInstagram(message: message);
    MySnackBar.show(title: result);
  }

  /// inbox page

  void getMyMessages() async {
    var message = await FireStore.getMyMessages();
    messagesObs.value = message;
    Log.d(message);
  }

  void onClickMessage(int index, Message data) async {
    if(data.read == false) {
      await FireStore.updateReadState(data.docId);
      messagesObs.value[index].read = true;
      messagesObs.refresh();
    }
    MyNav.pushNamed(
      pageName: PageName.inbox,
      arguments: { 'message': data },
    );
  }


  void getDeviceInfoTest() async {
    deviceInfoObs.value = await InfoUtil.getAllDeviceInfo();
  }

  @override
  void onBackPressed() { }

  @override
  void onNextPressed() { }

}
