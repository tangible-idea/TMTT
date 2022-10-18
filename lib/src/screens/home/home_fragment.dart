
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/screens/base/base_fragment_container.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
import 'package:tmtt/src/widgets/app_space.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';
import 'package:tmtt/src/widgets/plain_text_field.dart';

import '../../../generated/assets.dart';
import '../../resources/styles/txt_style.dart';
import '../../widgets/multiline_text_field.dart';
import '../../widgets/rounded_button.dart';

class HomeFragment extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => FragmentContainer(
      child: Stack(
        children: [
          Container(decoration: const BoxDecoration(
              color: MyColor.kPrimary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: Container(decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(32))
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 50, 25, 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      PlainText(
                          text: 'Ask question to your followers!',
                        style: MyTextStyle.h5,
                      ),
                      AppSpaces.verticalSpace20,

                      // PlainTextField(
                      //   hintText: '[test]Your instagram ID here.',
                      //   keyboardType: TextInputType.text,
                      //   controller: controller.inputController,
                      // ),
                      //AppSpaces.verticalSpace20,
                      PlainText(
                          text: controller.userNameObs.value
                      ),
                      PlainText(
                          text: controller.instaBioObs.value
                      ),
                      MultiLineTextField(
                        maxLength: 75,
                        maxLine: 3,
                        hintText: 'Ask question to your followers.',
                        controller: controller.messageInputController,
                      ),
                      AppSpaces.verticalSpace20,
                      PlainText(
                        text: 'Copy your link and share!',
                        style: MyTextStyle.h5,
                      ),
                      AppSpaces.verticalSpace10,

                      BottomPlainButton(
                        text: 'Copy link',
                        icon: SvgPicture.asset(Assets.imagesIcoCopy),
                        onPressed: () => controller.copyMyLink(),
                        enabledObs: RxBool(true),
                      ),

                      // Container(decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image: SvgPicture.asset(Assets.imagesInviteFriends)
                      //     )
                      //   ),
                      // ),
                      SvgPicture.asset(Assets.imagesInviteFriends),

                      // PlainText(
                      //     text: 'my link: ${controller.myLinkObs.value}'
                      // ),
                      BottomPlainButton(
                        text: '링크 복사하기',
                        onPressed: () => controller.copyMyLink(),
                        enabledObs: RxBool(true),
                      ),
                      BottomPlainButton(
                        text: '상태메시지 수정하기',
                        onPressed: () => controller.editMyStateMessage(),
                        enabledObs: RxBool(true),
                      ),
                      BottomPlainButton(
                        text: '인스타에 공유하기',
                        onPressed: () => controller.shareOnInstagram(context),
                        enabledObs: RxBool(true),
                      ),
                      BottomPlainButton(
                        text: '인스타 아이디 검색',
                        onPressed: () => controller.searchInstaUser(),
                        enabledObs: RxBool(true),
                      ),

                      AppSpaces.verticalSpace20,
                      PlainText(
                        text: 'Copy your link and share!',
                        style: MyTextStyle.h5,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    ));
  }
}