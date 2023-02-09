
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/data/model/hint.dart';
import 'package:tmtt/data/model/user.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/src/constants/URLs.dart';
import 'package:tmtt/src/constants/app_secret.dart';
import 'package:tmtt/src/network/retrofit_custom_manager.dart';
import 'package:tmtt/src/screens/base/base_get_controller.dart';
import 'package:tmtt/src/screens/write_message/message_input_fragment.dart';
import 'package:tmtt/src/screens/write_message/not_found_fragment.dart';
import 'package:tmtt/src/screens/write_message/send_success_fragment.dart';
import 'package:tmtt/src/util/info_util.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../resources/languages/strings.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
// import 'package:tmtt/src/util/download_link_native.dart'
//   if (dart.library.html) 'package:tmtt/src/util/download_link.dart' as link;


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
    getUserId();
    setHint();
    getPromotionImage();
  }

  late final inputController = TextEditingController();

  Hint? hint;

  var userNameObs = ''.obs;
  var userMessageObs = ''.obs;
  var userImageObs = ''.obs;
  var currentUserId = '';
  var currentUser = User();

  var promotionImageURL= ''.obs;

  final writePage = 0;
  final successPage = 1;
  final sendSuccessPage = 2;

  final enableSendButtonObs = false.obs;

  var currentPageIndexObs = 0.obs;
  List<Widget> pages = [
    const MessageInputFragment(),
    const MessageSendSuccessFragment(),
    const NotFoundUserFragment()
  ];


  void getPromotionImage() async {
    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance.ref()
        .child('promotion')
        .child('featured_card.png');
    promotionImageURL.value= await ref.getDownloadURL();
    //return await ref.getDownloadURL();
  }

  Future<void> getUserId() async {

    String userName = Get.parameters['uid'] ?? '';
    currentUserId = userName;
    var user = await FireStore.searchUserSlug(userName);
    if (user == null) {
      // userNameObs.value = 'not found user id';
      currentPageIndexObs.value = sendSuccessPage;
      return;
    }
    currentUser = user;
    userNameObs.value = "@${user.slugId}";
    userMessageObs.value= user.message;
    if(user.profileImage.isNotEmpty) {
      userImageObs.value= user.profileImage;
    }

    // Viewed by others: increase point by 1
    FireStore.increasePointOf(user.slugId, 1);
  }

  void setHint() async {
    hint = await InfoUtil.getHint();
  }

  // app download dynamiclink
  void onClickDownloadButton() async {
    // TODO: web version에서만 동작.
    if(kIsWeb) {
      js.context.callMethod('open', ["https://tmtt.link/invitation/appdownload"]);
      // launchDownloadLink();
    }
  }

  Future<void> writeMessage() async {
    String message = inputController.text;
    if(message.isEmpty) { return; }
    if(hint == null) { return; }
    currentPageIndexObs.value = successPage;

    await FireStore.writeMessage(
        user: currentUser,
        message: message,
        hint: hint!,
        emojiCode: 0
    );


    var service = RetrofitCustomManager(
        baseURL: MyUrl.flareLanePushUrl,
    ).retrofitService;
    //Log.d('currentUser.documentId: ${currentUser.documentId}');

    var header = "Bearer ${AppSecret.FLARELANE_API_KEY}";

    var body = {
      'targetType': "userId",
      'targetIds': <String>[currentUser.documentId],
      'title': Strings.pushNewMessageTitle.tr,
      'body': Strings.pushNewMessageContent.tr
    };

    var result = await service.notifications(header, body);
    Log.d("result: $result");

  }

  @override
  void onClose() {
    Log.d('onClose WriteMessageController');
    inputController.dispose();
  }

}