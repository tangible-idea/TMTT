import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/resources/styles/btn_style.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/screens/base/base_dialog_container.dart';
import 'package:tmtt/src/screens/base/base_widget.dart';
import 'package:tmtt/src/util/inapp_purchase_util.dart';
import 'package:tmtt/src/widgets/app_space.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

import '../../pages.dart';
import '../resources/languages/strings.dart';
import '../util/my_navigator.dart';


class PaymentDialog extends BaseWidget {

  late Function() onClickPay;

  PaymentDialog({
    required this.onClickPay,
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
              text: Strings.messageButtonWhoSentThis.tr,
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
              text: Strings.messageUnlockBody.tr,
              style: MyTextStyle.body1.copyWith(
                  fontSize: 16
              ),
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
            child: BottomPlainButton(
              icon: SvgPicture.asset(Assets.imagesLockIcon),
              text: Strings.messageUnlockButton.tr,
              style: BtnStyle.plain.copyWith(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  return MyColor.kPink; // if (states.contains(MaterialState.pressed)) {}
                }),
              ),
              enabledObs: RxBool(true),
              onPressed: () => onClickPay(),
            ),
          ),
          Center(
            child: PlainText(
              marginBottom: 14,
              align: TextAlign.center,
              text: Strings.messageUnlockRenewWarning.tr,
              style: MyTextStyle.body1.copyWith(
                  fontSize: 13,
                  color: MyColor.gray_03
              ),
            ),
          ),
          InkWell(
              child: Center(
                child: PlainText(
                    text: Strings.settingTermsOfUse1.tr,
                    align: TextAlign.center,
                    style: MyTextStyle.body1.copyWith(
                      fontSize: 13,
                      color: MyColor.gray_04,
                      decoration: TextDecoration.underline,
                      ),
                ),
              ),
            onTap: () => MyNav.pushNamed(pageName: PageName.terms)
          ),
          AppSpaces.verticalSpace10
        ],
      ),
    );
  }
}