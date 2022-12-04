
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:tmtt/data/model/hint.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/src/bottom_dialog/payment_dialog.dart';
import 'package:tmtt/src/bottom_dialog/hint_dialog.dart';
import 'package:tmtt/src/util/inapp_purchase_util.dart';
import 'package:tmtt/src/util/my_dialog.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:tmtt/src/util/my_snackbar.dart';
import 'package:tmtt/src/util/posting_helper.dart';
import 'package:tmtt/src/util/posting_helper.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
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

  // WidgetsToImageController to access widget
  WidgetsToImageController captureController = WidgetsToImageController();
// to save image bytes of widget
  Uint8List? bytes;


  @override
  void onInit() {
    // TODO: Get.arguments 에서 message 항목없을 경우 -> 메시지 항목 다시 얻어와야함?
    var message = Get.arguments['message'] as Message;
    messageObs.value = message;
  }

  int getIndex() => Get.arguments['index'] as int;
  String getProfile() => Get.arguments['profileUrl'] as String;


  @override
  void onClose() { }

  void onClickReply() async {

    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);
    final bytes = await captureController.capture();
    if(bytes != null) {
      await PostingHelper.shareOnInstagramReply(bytes);
    }else{
      MySnackBar.show(title: "Error", message: "There's an error while replying.");
    }
    EasyLoading.dismiss();
  }

  void onClickHint() async {
    var customerInfo = await Purchase.getCustomerInfo();
    if (customerInfo == null) { return; }
    var isSubscribe = await Purchase.isUserActiveSubscribe(customerInfo);
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
      onClickPay: () => startPayment(),
    );
    MyDialog.showBottom(
      widget: dialog,
      isEnableDrag: true,
      isFullScreen: false,
    );
  }

  void startPayment() async {
    showLoading();
    var offerings = await Purchase.displayProducts();

    Package? product;
    if(GetPlatform.isAndroid) {
      product = offerings?.all["weekly_payment"]?.weekly;
    } else if(GetPlatform.isIOS) {
      product = offerings?.all["weekly_payment"]?.weekly;
    }

    if (offerings == null || product == null) {
      dismissLoading();
    }

    if (offerings != null && product != null) {
      var paymentResult = await Purchase.makePurchase(product);
      if(paymentResult == null) {
        dismissLoading();
        return;
      }
      var isSubscribe = await Purchase.isUserActiveSubscribe(paymentResult);
      dismissLoading();
      if(isSubscribe) {
        Get.back();
        startHintDialog();
      }
    }
  }

}

