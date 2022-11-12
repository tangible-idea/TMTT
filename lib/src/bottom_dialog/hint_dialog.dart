
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmtt/data/model/hint.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/screens/base/base_dialog_container.dart';
import 'package:tmtt/src/screens/base/base_widget.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

import '../resources/languages/strings.dart';


class HintDialog extends BaseWidget {

  late String email;
  late Message message;
  late Function() onPayPressed;

  HintDialog({
    required this.email,
    required this.message,
    required this.onPayPressed,
  });

  @override
  void onInit() {
  }

  @override
  Widget onBuild(BuildContext context) {
    return BottomDialogContainer(
      decoration: BoxDecoration(
        color: MyColor.kPrimary,
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
                  color: MyColor.white,
                  fontSize: 20
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: ListView(
                children: [
                  item(Assets.imagesLocationIcon, Strings.messageHint1.tr, message.hint.city),
                  item(Assets.imagesCountryIcon, Strings.messageHint2.tr, message.hint.country),
                  item(Assets.imagesTimeSentIcon,Strings.messageHint3.tr, message.createDate),
                  item(Assets.imagesCarrierIcon, Strings.messageHint4.tr, message.hint.carrierIsp),
                  item(Assets.imagesSettingIcon, Strings.messageHint5.tr, message.hint.platform),
                  item(Assets.imagesDeviceIcon,  Strings.messageHint6.tr, message.hint.device),
                  item(Assets.imagesSettingIcon, Strings.messageHint7.tr, message.hint.os),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget item(String asset, String title, String content) {
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, top: 12, bottom: 12),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 9),
            child: SvgPicture.asset(asset, color: MyColor.white),
          ),
          PlainText(
            text: title,
            style: MyTextStyle.body1Bold.copyWith(color: MyColor.white),
            marginRight: 24,
          ),
          Expanded(
            child: PlainText(
              text: content,
              align: TextAlign.right,
              style: MyTextStyle.body.copyWith(color: MyColor.white),
            ),
          )
        ],
      ),
    );
  }
}