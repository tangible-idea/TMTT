
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/resources/languages/strings.dart';
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
    return //Row(children: [],);
      Obx(() =>
        Column(
          children: [
            // Center(
            //   child: PlainText(
            //     marginTop: 30,
            //     align: TextAlign.center,
            //     text: controller.userNameObs.value,
            //     style: MyTextStyle.h3.copyWith(color: MyColor.kWhite),
            //   ),
            // ),


            AppSpaces.verticalSpace40,
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,30,0,0),
                  child: SvgPicture.asset(Assets.imagesQuestionBoardabout),
                ),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: MyColor.kLightBackground,
                  foregroundImage: NetworkImage(controller.userImageObs.value),
                ),

                Center(
                  child: SizedBox(
                    width: 250,
                    child: PlainText(
                      marginTop: 75,
                      marginBottom: 50,
                      text: controller.userMessageObs.value,
                      style: MyTextStyle.h5.copyWith(color: MyColor.kWhite),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 25, left: 18, right: 18),
                decoration: BoxDecoration(
                  color: MyColor.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      // margin: const EdgeInsets.only(left: 14, right: 14),
                      child: MultiLineTextField(
                        maxLength: 50,
                        maxLine: 4,
                        keyboardType: TextInputType.text,
                        textStyle: MyTextStyle.formInputBig,
                        filled: false,
                        hintText: Strings.messageWrite1.tr,
                        controller: controller.inputController,
                        onChanged: (text) => {
                          controller.enableSendButtonObs.value = text.isNotEmpty
                        },
                      ),
                    ),
                    AppSpaces.verticalSpace20,
                    Container(
                      margin: const EdgeInsets.only(left: 14, right: 14),
                      child: BottomPlainButton(
                        text: Strings.messageWrite2.tr,
                        textStyle: MyTextStyle.body1Bold.copyWith(color: MyColor.kWhite,),
                        onPressed: () => controller.writeMessage(),
                        enabledObs: controller.enableSendButtonObs,//controller.inputController.text.isNotEmpty.obs,
                        style: BtnStyle.valentineButton,
                        disableStyle: BtnStyle.valentineDisableButton,
                      ),
                    ),
                    AppSpaces.verticalSpace5,
                    PlainText(
                      text: Strings.messageWrite3.tr,
                      style: MyTextStyle.contentSmall,),
                    AppSpaces.verticalSpace50,
                  ],
                ),
              ),
            ),
            AppSpaces.verticalSpace50,
          ],
    ));
  }
}
