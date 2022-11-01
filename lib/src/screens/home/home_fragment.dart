
import 'package:cached_network_image/cached_network_image.dart';
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
import '../../widgets/button_white.dart';
import '../../widgets/multiline_text_field.dart';

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
            child: Expanded(
              child: ListView(
                children: [
                  PlainText(
                      text: 'Ask question to your followers!',
                    style: MyTextStyle.h5,
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

                  Row(
                    children: [
                      WhiteButton(
                        icon: SvgPicture.asset(Assets.imagesIcoRandom, color: MyColor.kPrimary),
                        text: 'Random',
                        onPressed: () => controller.putARandomMessage(),
                        enabledObs: RxBool(true),
                      ),
                      const Spacer(),
                      WhiteButton(
                        icon: SvgPicture.asset(Assets.imagesIcoArrowdown, color: MyColor.kPrimary),
                        text: 'Template',
                        onPressed: () => controller.editMyStateMessage(),
                        enabledObs: RxBool(true),
                      ),
                    ],
                  ),

                  AppSpaces.verticalSpace10,
                  PlainText(
                    text: 'Copy your link and share!',
                    style: MyTextStyle.h5,
                  ),
                  AppSpaces.verticalSpace10,

                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                            maxHeight: 100,
                          ),
                          color: MyColor.kSecondary,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Stack(
                              children: [
                                // Your profile picture here
                                InkWell(
                                  onTap: () { controller.changeProfileImage(); },
                                  child: controller.profileURL.value != ""
                                      ? CircleAvatar(

                                        backgroundColor: Colors.white, radius: 37,
                                        child: CircleAvatar(
                                            backgroundImage: CachedNetworkImageProvider(controller.profileURL.value),
                                            radius: 35),
                                      )
                                      : SvgPicture.asset(Assets.imagesInviteYourprofile)),

                                controller.profileURL.value == "" ?
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SvgPicture.asset(Assets.imagesIcoPlus, color: MyColor.gray_03),
                                ) : const Spacer(),
                              ],
                            ),
                            SvgPicture.asset(Assets.imagesInviteArrows),
                            SvgPicture.asset(Assets.imagesInvite3guys),
                          ],),
                        ),
                        Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                            maxHeight: 340,
                          ),
                          color: MyColor.kLightBackground,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppSpaces.verticalSpace30,
                              PlainText(
                                text: 'Step1: Copy your link!',
                                style: MyTextStyle.caption2Bold,
                              ),

                              AppSpaces.verticalSpace10,
                              PlainText(
                                  text: 'https://tmtt.link/#/${controller.userNameObs.value}'
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                                child: BottomPlainButton(
                                  text: 'Copy link',
                                  icon: SvgPicture.asset(Assets.imagesIcoCopy),
                                  onPressed: () => controller.copyMyLink(),
                                  enabledObs: RxBool(true),
                                ),
                              ),

                              AppSpaces.verticalSpace20,

                              PlainText(
                                marginLeft: 30,
                                marginRight: 30,
                                align: TextAlign.center,
                                text: 'Step2: Share your link on your instagram Story.',
                                style: MyTextStyle.caption2Bold,
                              ),
                              AppSpaces.verticalSpace5,
                              Padding(
                                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                                child: BottomPlainButton(
                                  text: 'Share',
                                  icon: SvgPicture.asset(Assets.imagesIcoShare),
                                  onPressed: () => controller.shareOnInstagram(context),
                                  enabledObs: RxBool(true),
                                ),
                              ),
                            ],)
                        ),
                      ],
                    ),
                  ),


                  AppSpaces.verticalSpace20,
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}