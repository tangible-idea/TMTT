
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/resources/styles/btn_style.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/widgets/app_space.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/multiline_text_field.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

import 'write_message_controller.dart';

class MessageInputFragment extends GetView<WriteMessageController> {

  const MessageInputFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [],);
    //   Obx(() =>
    //     Column(
    //     children: [
    //       Center(
    //         child: PlainText(
    //           marginTop: 30,
    //           align: TextAlign.center,
    //           text: controller.userNameObs.value,
    //           style: MyTextStyle.h3,
    //         ),
    //       ),
    //       Center(
    //         child: PlainText(
    //           marginTop: 4,
    //           text: controller.userMessageObs.value,
    //           style: MyTextStyle.body16.copyWith(color: MyColor.kGrey2),
    //         ),
    //       ),
    //       AppSpaces.verticalSpace10,
    //       MultiLineTextField(
    //         maxLength: 100,
    //         maxLine: 4,
    //         hintText: 'Send me anonymouse message...',
    //         controller: controller.inputController,
    //       ),
    //       BottomPlainButton(
    //         icon: const Icon(
    //           Icons.send_rounded,
    //           color: MyColor.kPrimary,
    //         ),
    //         text: 'Send anonymously',
    //         textStyle: MyTextStyle.body1Bold.copyWith(color: MyColor.kPrimary,),
    //         onPressed: () => controller.writeMessage(),
    //         enabledObs: RxBool(true),
    //         style: BtnStyle.whiteOutlineRadius2,
    //       ),
    //     ],
    // ));
  }
}
