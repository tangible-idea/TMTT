
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart' as firebase_user;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
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
import 'package:tmtt/src/util/credentials.dart';
import 'package:tmtt/src/util/inapp_purchase_util.dart';
import 'package:tmtt/src/util/info_util.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:tmtt/src/util/my_navigator.dart';
import 'package:tmtt/src/util/my_snackbar.dart';
import 'package:tmtt/src/util/posting_helper.dart';

import '../../constants/sample_questions.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends BaseGetController {

  @override
  void onInit() {
    //checkPageFlow();
    getMyInfo();
    getInsta();
    loadProfilePicture();
    pushTokenListener();
  }

  void getInsta() async {
    // var instaInfo = await InfoUtil.getInstagramInfo('hunkim_food');
    // Log.d(instaInfo);

  }

  @override
  void onClose() {
    inputController.dispose();
    messageInputController.dispose();
  }

  /// tab navigation
  var currentPageIndexObs = 0.obs;
  List<Widget> pages = [ HomeFragment(), InboxFragment(), SettingFragment() ];
  List<String> pageTitles = [ 'TMTT', 'Messages', 'Settings', ];

  /// ========================================================

  late final inputController = TextEditingController();
  late final messageInputController = TextEditingController();

  /// ========================================================

  var userNameObs = ''.obs;
  var instaBioObs = ''.obs;
  var deviceInfoObs = ''.obs;
  var myInfoObs = User().obs;
  var myLinkObs = ''.obs;
  var messagesObs = <Message>[].obs;
  var useHeaderObs = false.obs;

  var profileURL= ''.obs;

  void pushTokenListener() async {

    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {
      // send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
      FireStore.updateUserValue("pushToken", fcmToken);
    })
        .onError((err) {
        // Error getting token.
        Log.e(err);
    });
  }

  void searchInstaUser() async {
    String userName = inputController.text;
    FlutterInsta flutterInsta = FlutterInsta();
    await flutterInsta.getProfileData(userName); //instagram username
    instaBioObs.value = flutterInsta.bio;
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
    userNameObs.value = myInfo.slugId;
    myLinkObs.value = '${MyUrl.baseUrl}#/${myInfo.slugId}';
    myInfoObs.value = myInfo;

    Log.d('Purchase.getUserId: ${await Purchase.getUserId()}');
    var userInfo = await Purchase.getCustomerInfo();
    if (userInfo != null) {
      var isSubscribe = await Purchase.isUserActiveSubscribe(userInfo);
      Log.d('isSubscribe: $isSubscribe');
    }

    var offerings = await Purchase.displayProducts();
    // var product = offerings?.current?.availablePackages[0];
    var product = offerings?.current?.weekly;

    // if (offerings != null && product != null) {
    //   await Purchase.makePurchase(product);
    // }

    if(myInfoObs.value.pushToken.isEmpty) {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        FireStore.updateUserValue("push_token", fcmToken.toString());
    }

    checkPageFlow();
  }

  // check auth data and slug data.
  void checkPageFlow() {
    firebase_user.FirebaseAuth.instance
        .authStateChanges()
        .listen((user) {
        if (user == null) {
          print('User is currently signed out!');
          MyNav.pushReplacementNamed(
            pageName: PageName.register,
          );
        } else {
          print('User is signed in!');
          if(myInfoObs.value.slugId.isEmpty) { // 계정있는데 슬러그 없으면 : 슬러그 생성페이지.
            MyNav.pushReplacementNamed(
              pageName: PageName.createslug,
            );
          }
        }
    });
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

  // Get profile image's profile picture from Firebase Storage
  Future<void> loadProfilePicture() async {
    Reference ref = FirebaseStorage.instance.ref()
        .child('profile')
        .child('/image_${getMyUID()}');

    profileURL.value= await ref.getDownloadURL();
  }

  // get login info.
  String getMyUID() {
    var currUser= firebase_user.FirebaseAuth.instance.currentUser;
    if(currUser == null) {
      MySnackBar.show(title: 'Error', message: 'Login required.');
      MyNav.pushNamed(pageName: PageName.register);
      return "";
    }else{
      return currUser.uid;
    }
  }

  void changeProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? xfile = await picker.pickImage(source: ImageSource.gallery);
    //file!.path
    var myInfo= await FireStore.getMyInfo();
    if (myInfo == null) { return; }

    FireStore.uploadMyPhotoToStorage(xfile!.path);

    // final metadata = SettableMetadata(
    //   contentType: 'image/jpeg',
    //   customMetadata: {'picked-file-path': xfile!.path},
    // );

    loadProfilePicture();
  }


  // Put a random message on question text controller.
  void putARandomMessage() {
    var randomInt= Random().nextInt(Samples.questions_kr_1.length);
    String randomText= Samples.questions_kr_1[randomInt];
    messageInputController.text= randomText;
  }


  bool isTextValid() {
    if(messageInputController.text.isEmpty) {
      MySnackBar.show(title: 'Please write your message first.');
      return false;
    }
    return true;
  }

  // 인스타에 공유하기
  Future<void> shareOnInstagram(BuildContext context) async {

    if(!isTextValid()) return; // validation check

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
      arguments: {
        'message': data,
        'index': index,
        'profileUrl': profileURL.value
      },
    );
  }


  void getDeviceInfoTest() async {
    deviceInfoObs.value = await InfoUtil.getAllDeviceInfo();
  }

  void recreateYourSulg() {
    MyNav.pushReplacementNamed(
      pageName: PageName.createslug,
    );
  }

  void signOut() async {
    await Credentials.logout();
    MyNav.pushReplacementNamed(
      pageName: PageName.register,
    );
  }

  void openPrivacy() {
    MyNav.pushNamed(pageName: PageName.privacy);
  }

  @override
  void onBackPressed() { }

  @override
  void onNextPressed() { }

}
