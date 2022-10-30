import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_dialog_container.dart';
import 'package:tmtt/src/screens/base/base_widget.dart';
import 'package:tmtt/src/util/inapp_purchase_util.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';


class PaymentDialog extends BaseWidget {

  late Function() onPaySuccess;

  PaymentDialog({
    required this.onPaySuccess,
  });

  @override
  void onInit() {

  }

  @override
  Widget onBuild(BuildContext context) {
    return BottomDialogContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomPlainButton(
            text: 'cancel!',
            enabledObs: RxBool(true),
            onPressed: () => Get.back(),
          ),
          BottomPlainButton(
            text: 'pay!',
            enabledObs: RxBool(true),
            onPressed: () => payment(),
          ),
        ],
      ),
    );
  }

  void payment() async {
    var offerings = await Purchase.displayProducts();
    var product = offerings?.current?.weekly;
    if (offerings != null && product != null) {
      var paymentResult = await Purchase.makePurchase(product);
      if(paymentResult == null) return;
      var isSubscribe = await Purchase.isUserActiveSubscribe(paymentResult);
      if(isSubscribe) {
        Get.back();
        onPaySuccess();
      }
    }
  }
}