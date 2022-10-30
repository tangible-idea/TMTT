import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/resources/styles/btn_style.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/screens/base/base_dialog_container.dart';
import 'package:tmtt/src/screens/base/base_widget.dart';
import 'package:tmtt/src/util/inapp_purchase_util.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';


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
      height: 280,
      decoration: BoxDecoration(
        color: MyColor.kLightBackground,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: PlainText(
              marginTop: 32,
              marginBottom: 14,
              text: "Who sent this",
              style: MyTextStyle.body1Bold.copyWith(
                  fontSize: 20
              ),
            ),
          ),
          Center(
            child: PlainText(
              marginTop: 12,
              marginBottom: 14,
              marginRight: 24,
              marginLeft: 24,
              align: TextAlign.center,
              text: "Premium members can see exclusive hints on each message.",
              style: MyTextStyle.body1.copyWith(
                  fontSize: 16
              ),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(left: 14, right: 14, bottom: 14),
            child: BottomPlainButton(
              icon: SvgPicture.asset(Assets.imagesLockIcon),
              text: 'Unlock messages',
              style: BtnStyle.plain.copyWith(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  return MyColor.kPink; // if (states.contains(MaterialState.pressed)) {}
                }),
              ),
              enabledObs: RxBool(true),
              onPressed: () => payment(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 14, right: 14, bottom: 14),
            child: Center(
              child: PlainText(
                marginBottom: 14,
                align: TextAlign.center,
                text: "It renews for 'price' per week. 'Terms and Privacy'",
                style: MyTextStyle.body1.copyWith(
                    fontSize: 12,
                    color: MyColor.gray_03
                ),
              ),
            ),
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