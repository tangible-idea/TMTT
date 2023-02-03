
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

            //AppSpaces.verticalSpace20,

            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25,0,0,0),
                  child: Image.asset(Assets.imagesQuestionInputBoard),
                ),
                Column(
                  children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(45, 50, 45, 0),
                    child: SizedBox(
                      width: 260,
                      child: MultiLineTextField(
                        maxLength: 45,
                        maxLine: 4,
                        textStyle: MyTextStyle.formInputBig,
                        filled: false,
                        hintText: '메시지를 적어주세요.',
                        controller: controller.inputController,
                      ),
                    ),
                  ),

                  Column(
                    children: [
                      SizedBox(
                        width: 240,
                        child: BottomPlainButton(
                          text: '익명으로 초콜렛🍫 보내기  >',
                          textStyle: MyTextStyle.body1Bold.copyWith(color: MyColor.kWhite,),
                          onPressed: () => controller.writeMessage(),
                          enabledObs: true.obs,//controller.inputController.text.isNotEmpty.obs,
                          style: BtnStyle.valentineButton,
                        ),
                      ),
                      AppSpaces.verticalSpace5,
                      PlainText(
                        text: "🔒 메세지는 익명처리 되어집니다. 🔒",
                        style: MyTextStyle.contentSmall,),
                      AppSpaces.verticalSpace100,
                      AppSpaces.verticalSpace50,
                    ],
                  ),

                ],
              ),

              ],
            ),



            AppSpaces.verticalSpace10,


          ],
    ));
  }
}
