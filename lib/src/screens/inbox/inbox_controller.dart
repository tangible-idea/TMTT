
import 'package:get/get.dart';
import 'package:tmtt/data/model/hint.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/src/bottom_dialog/send_email_auth_dialog.dart';
import 'package:tmtt/src/util/my_dialog.dart';
import 'package:tmtt/src/util/my_logger.dart';

import '../base/base_get_controller.dart';

class InboxBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InboxController());
  }
}

class InboxController extends BaseGetController {

  var messageObs = Message(hint: Hint()).obs;

  @override
  void onInit() {
    var message = Get.arguments['message'] as Message;
    messageObs.value = message;
  }

  @override
  void onClose() { }

  void onClickHint() {
    var dialog = SendEmailAuthDialog(
        email: 'email',
        onTermsPressed: () {},
        onNextPressed: () {}
    );
    MyDialog.showBottom(
      widget: dialog,
      isCancelable: true,
      isFullScreen: false,
    );
  }

}

