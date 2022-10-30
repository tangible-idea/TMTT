
import 'package:get/get.dart';
import 'package:tmtt/data/model/hint.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/src/bottom_dialog/payment_dialog.dart';
import 'package:tmtt/src/bottom_dialog/hint_dialog.dart';
import 'package:tmtt/src/util/inapp_purchase_util.dart';
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

  var isReceiveImageObs = false.obs;

  @override
  void onInit() {
    var message = Get.arguments['message'] as Message;
    messageObs.value = message;
  }

  int getIndex() => Get.arguments['index'] as int;
  String getProfile() => Get.arguments['profileUrl'] as String;


  @override
  void onClose() { }

  void onClickHint() async {
    var customerInfo = await Purchase.getCustomerInfo();
    if (customerInfo == null) { return; }
    var isSubscribe = await Purchase.isUserActiveSubscribe(customerInfo);
    Log.d("isSubscribe: $isSubscribe");
    if(isSubscribe) {
      startHintDialog();
    } else {
      startPaymentDialog();
    }
  }
  void startHintDialog() {
    var dialog = HintDialog(
      email: 'email',
      message: messageObs.value,
      onPayPressed: () {},
    );
    MyDialog.showBottom(
      widget: dialog,
      isEnableDrag: true,
      isFullScreen: false,
    );
  }
  void startPaymentDialog() {
    var dialog = PaymentDialog(
      onPaySuccess: () => startHintDialog(),
    );
    MyDialog.showBottom(
      widget: dialog,
      isEnableDrag: true,
      isFullScreen: false,
    );
  }

}

