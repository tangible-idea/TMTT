
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/resources/languages/strings.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/screens/write_message/write_message_controller.dart';
import 'package:tmtt/src/widgets/app_space.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

import '../../resources/styles/btn_style.dart';
import '../../resources/styles/txt_style.dart';
import '../../widgets/bottom_button.dart';

class MessageSendSuccessFragment extends GetView<WriteMessageController> {

  const MessageSendSuccessFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 500,
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: MyColor.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                AppSpaces.verticalSpace20,
                Image.asset(Assets.imagesButtonDone, width: 210, height: 210),

                PlainText(
                  text: Strings.messageSendSuccess1.tr,
                  align: TextAlign.center,
                ),
                Spacer(),
                SizedBox(
                  width: 260,
                  child: BottomPlainButton(
                    text: Strings.messageSendSuccess2.tr,
                    onPressed: () => controller.onClickDownloadButton(),
                    enabledObs: RxBool(true),//controller.inputController.text.isNotEmpty.obs,
                  ),
                ),
                PlainText(
                  marginTop: 10,
                  text: Strings.messageSendSuccess3.tr,
                  align: TextAlign.center,
                  style: MyTextStyle.contentSmall,
                ),
              ],
            ),
          ),
        ],
      );
  }
}
