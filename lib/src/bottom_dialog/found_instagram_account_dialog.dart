
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/screens/base/base_dialog_container.dart';
import 'package:tmtt/src/screens/base/base_widget.dart';
import 'package:tmtt/src/widgets/app_space.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';


class FoundInstagramAccountDialog extends BaseWidget {

  late String follower;
  late String following;
  late String instagramId;
  late String instagramName;
  late String instagramBio;
  late String instagramImageURL;
  late Function() onYesPressed;
  late Function() onNoPressed;

  FoundInstagramAccountDialog({
    super.key,
    required this.follower,
    required this.following,
    required this.instagramId,
    required this.instagramName,
    required this.instagramBio,
    required this.instagramImageURL,
    required this.onYesPressed,
    required this.onNoPressed,
  });

  // @override
  // Widget build(BuildContext context) {
  //   return
  // }

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
          PlainText(text: "LINK YOUR INSTAGRAM ACCOUNT", style: MyTextStyle.caption2Bold.copyWith(
            color: MyColor.kGrey2
          ),),
          AppSpaces.verticalSpace10,
          PlainText(text: "Is this your account?", style: MyTextStyle.h3),
          AppSpaces.verticalSpace20,

          // PlainText(text: "YOUR BIO", style: MyTextStyle.caption2Bold.copyWith(
          //     color: MyColor.kGrey2
          // ),),
          AppSpaces.verticalSpace20,

          Row(children: [
            CircleAvatar(backgroundImage: NetworkImage(instagramImageURL), radius: 30),
            AppSpaces.horizontalSpace10,
            AppSpaces.horizontalSpace5,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              PlainText(text: instagramId, style: MyTextStyle.body16bold),
              PlainText(text: instagramName, style: MyTextStyle.body16.copyWith(
                  color: MyColor.kGrey2
              ),),
              PlainText(text: 'Followers: ${follower} | Following: ${following}', style: MyTextStyle.body16.copyWith(
                  color: MyColor.kGrey2
              ),),
            ],),
          ],),
          AppSpaces.verticalSpace10,
          PlainText(text: instagramBio,  style: MyTextStyle.body16),


          Spacer(),
          BottomPlainButton(
            text: 'Yes! Link please.',
            enabledObs: RxBool(true),
            onPressed: () {
              Get.back();
              onYesPressed();
            },
          ),
          BottomPlainButton(
            text: "Use without it.",
            enabledObs: RxBool(true),
            onPressed: () {
              Get.back();
              onNoPressed();
            },
          ),
        ],
      ),
    );
  }
}