
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/data/model/hint.dart';
import 'package:tmtt/data/model/user.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/src/constants/URLs.dart';
import 'package:tmtt/src/network/retrofit_custom_manager.dart';
import 'package:tmtt/src/screens/base/base_get_controller.dart';
import 'package:tmtt/src/screens/write_message/message_input_fragment.dart';
import 'package:tmtt/src/screens/write_message/not_found_fragment.dart';
import 'package:tmtt/src/screens/write_message/send_success_fragment.dart';
import 'package:tmtt/src/util/info_util.dart';
import 'package:tmtt/src/util/my_logger.dart';

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
  }

  late final inputController = TextEditingController();

  Hint? hint;

  var userNameObs = ''.obs;
  var userMessageObs = ''.obs;
  var userImageObs = ''.obs;
  var currentUserId = '';
  var currentUser = User();

  final writePage = 0;
  final successPage = 1;
  final sendSuccessPage = 2;

  var currentPageIndexObs = 0.obs;
  List<Widget> pages = [
    const MessageInputFragment(),
    const MessageSendSuccessFragment(),
    const NotFoundUserFragment()
  ];

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
  }

  void setHint() async {
    hint = await InfoUtil.getHint();
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
        baseURL: MyUrl.firebaseFunctionsUrl,
    ).retrofitService;
    Log.d('currentUser.documentId: ${currentUser.documentId}');

    await service.sendPush({
      'senderUid': '',
      'targetUid': currentUser.documentId,
      'title': 'new message!',
      'message': '확인해보셈'
    });

  }

  @override
  void onClose() {
    Log.d('onClose WriteMessageController');
    inputController.dispose();
  }

}