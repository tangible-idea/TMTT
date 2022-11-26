
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart' as firebase_user;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flarelane_flutter/flarelane_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:get/get.dart';

import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/data/model/user.dart';
import 'package:tmtt/firebase/fcm_service.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/main.dart';
import 'package:tmtt/pages.dart';
import 'package:tmtt/src/constants/URLs.dart';
import 'package:tmtt/src/resources/languages/languages.dart';
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
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../constants/firestore_key.dart';
import '../../constants/local_storage_key_store.dart';
import '../../constants/sample_questions.dart';
import '../../resources/languages/strings.dart';
import '../../resources/styles/my_color.dart';
import '../../util/language_util.dart';
import '../../util/my_dialog.dart';

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
    loadProfilePicture();
    FcmService.setPushTokenListener();
    FcmService.setPushMessageListener();
    inboxScrollListener();
    purchaseTest();
  }

  void purchaseTest() async {
    Log.d('Purchase.getUserId: ${await Purchase.getUserId()}');
    var userInfo = await Purchase.getCustomerInfo();
    if (userInfo != null) {
      var isSubscribe = await Purchase.isUserActiveSubscribe(userInfo);
      Log.d('isSubscribe: $isSubscribe');
    }

    var offerings = await Purchase.displayProducts();
    Log.d('offerings: $offerings');
    // var product = offerings?.current?.availablePackages[0];
    // var product = offerings?.current?.weekly;

    // if (offerings != null && product != null) {
    //   await Purchase.makePurchase(product);
    // }
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
  var isProfileLoading= false.obs; // 사진 로딩중 shimemring

  var focusedLang= ''.obs; // 설정에서 사용
  var selectedLang= ''.obs; // 설정에서 사용

  var helpPosition= 1.obs; // 도움말 페이지 인디케이터
  var helpDontShow= false.obs; // 도움말 보지않기 스위치.

  showNextHelpOr(BuildContext context, bool alsoShare) async {
    if(helpPosition.value < 4) {
      helpPosition.value = helpPosition.value +1;
    }else{
      Get.back();

      if(alsoShare) {
        EasyLoading.show(status: 'Loading...');
        await saveMyLastMessage();
        await shareOnInstagram(context);
        EasyLoading.dismiss();
      }
    }
  }

  WidgetsToImageController captureController = WidgetsToImageController(); // in order to capture rounded profile.

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

    FlareLane.shared.setUserId(myInfo.documentId); // set email as user id.

    // update push token. it isn't related to FlareLane.
    final fcmToken = await FcmService.token;
    FireStore.updateUserValue(FireStoreKey.push_token, fcmToken.toString());

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
    Clipboard.setData(ClipboardData(text: myLinkObs.value)).then((value) => {
      MySnackBar.show(title: Strings.homeButtonCopyLinkAction.tr)
    });

  }

  Future<void> saveMyLastMessage() async {
    var text = messageInputController.text;
    if(text.isEmpty) { return; }
    await FireStore.editMyLastMessage(text);
    Log.d('Your message has edited!');
    myInfoObs.value.message = text;
  }


  // Get profile image's profile picture from Firebase Storage
  Future<void> loadProfilePictureFromStorage() async {
    Reference ref = FirebaseStorage.instance.ref()
        .child('profile')
        .child('/image_${getMyUID()}');

    profileURL.value= await ref.getDownloadURL();
  }

  // Get profile image's profile picture from Firebase Storage
  Future<void> loadProfilePicture() async {
    isProfileLoading.value= true;
    var myinfo = await FireStore.getMyInfo();
    if(myinfo != null) {
      profileURL.value= myinfo.profileImage;
    }
    isProfileLoading.value= false;
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
    isProfileLoading.value= true;

    final ImagePicker picker = ImagePicker();
    final XFile? xfile = await picker.pickImage(source: ImageSource.gallery);
    //file!.path
    var myInfo= await FireStore.getMyInfo();
    if (myInfo == null) {
      loadProfilePicture();
      return;
    }

    if(xfile != null) {
      await FireStore.uploadMyPhotoToStorage(xfile.path);
    }

    // final metadata = SettableMetadata(
    //   contentType: 'image/jpeg',
    //   customMetadata: {'picked-file-path': xfile!.path},
    // );

    loadProfilePicture();
  }


  // Put a random message on question text controller.
  void putARandomMessage() {
    final langCode= Get.locale!.languageCode.toString();

    Samples.questions.keys.contains(langCode);
    final filteredList = {
      for (final key in Samples.questions.keys)
        if (key.startsWith(langCode)) key: Samples.questions[key]
    }.values.toList();

    var randomInt= Random().nextInt(filteredList.length);
    String randomText= filteredList[randomInt].toString();
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
    String result= '';

    var myInfo = await FireStore.getMyInfo();
    if (myInfo == null) { return; }

    if(myInfo.profileImage.isNotEmpty) { // With profile image
      final bytes = await captureController.capture();
      result = await PostingHelper.shareOnInstagram(myinfo: myInfo, message: message, profileImageBytes: bytes);
    }else{ // Without profile image.
      result = await PostingHelper.shareOnInstagram(myinfo: myInfo, message: message);
    }
    //MySnackBar.show(title: result);
    Log.d(result);
  }

  /// inbox page

  ScrollController inboxScrollController = ScrollController();
  int currentInboxPage = 0;

  void onRefreshMyMessage() {
    FireStore.lastVisibleInbox = null;
    getMyMessages();
  }

  void getMyMessages() async {

    if(FireStore.lastVisibleInbox == null) {
      var message = await FireStore.getMyMessagesFirst();
      messagesObs.value.clear();
      messagesObs.value.addAll(message);
      messagesObs.refresh();
      Log.d('call first page');
    } else {
      var message = await FireStore.getMyMessagesNext();
      if(message == null) { return; }
      messagesObs.value.addAll(message);
      messagesObs.refresh();
      Log.d('call next page');
    }

    // if(currentInboxPage == 0) {
    //   currentInboxPage+=1;
    //   var message = await FireStore.getMyMessagesFirst();
    //   messagesObs.value.addAll(message);
    //   messagesObs.refresh();
    //   Log.d(message);
    // }
  }

  void inboxScrollListener() {
    inboxScrollController.addListener(() {
      if (inboxScrollController.position.pixels == inboxScrollController.position.maxScrollExtent) {
        Log.d("detect bottom!");
        getMyMessages();
      }
    });
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

  void downloadInstagramProfile() async {
    FlutterInsta flutterInsta = FlutterInsta();
    await flutterInsta.getProfileData("sam_winter_h");

    Log.d(flutterInsta.imgurl);
    FireStore.linkMyPhotoFromInstagramAccountToStorage(flutterInsta.imgurl);
  }

  void startWhiteMessageTest() async {
    MyNav.pushNamed(
      pageName: "/sam_winter_h"
      // pageName: "/marks.photo"
    );
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


  void sendEmailWithHandlingResponse(Email email) async {
    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      MySnackBar.show(title: "There's no email app installed.", message: "Please setup your email account on your phone.");
    }
  }

  // send feedback
  void sendFeedback() async {
    final Email email = Email(
      body: Strings.settingFeedbackEmailBody.tr,
      subject: Strings.settingFeedbackEmailSubject.tr,
      recipients: ['help@tmtt.link'],
      cc: ['tmtt.link@gmail.com'],
      isHTML: false,
    );

    sendEmailWithHandlingResponse(email);
  }

  void deactivateYourAccount() async {
    final Email email = Email(
      body: "Are you sure you're gonna delete your account?",
      subject: 'TMTT deactivation.',
      recipients: ['help@tmtt.link'],
      cc: ['tmtt.link@gmail.com'],
      isHTML: false,
    );

    sendEmailWithHandlingResponse(email);
  }

  void showLanguageList(BuildContext context) async {

  }


  void changeAppLanguage() async {
    LocalStorage.put(KeyStore.language, focusedLang.value);
    await MyTmttApp.loadMyLanguage();
  }

  void openPrivacy() {
    MyNav.pushNamed(pageName: PageName.privacy);
  }

  @override
  void onBackPressed() { }

  @override
  void onNextPressed() { }

}
