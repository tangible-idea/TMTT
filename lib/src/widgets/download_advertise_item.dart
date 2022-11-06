
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/resources/styles/btn_style.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

class DownLoadAdvertiseItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 18),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: MyColor.kSecondary,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(Assets.imagesGreetingMan),
            ),
            const Spacer(),
            PlainText(
              text: "Download the app to\nsend messages with\nmore special features..",
              style: MyTextStyle.body1Bold.copyWith(
                fontSize: 17,
                color: MyColor.white,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(Assets.imagesGreetingGirl),
            ),
            const Spacer(),
            BottomPlainButton(
              text: 'Get my own message!',
              textStyle: MyTextStyle.body2Bold.copyWith(color: MyColor.kPrimary,),
              onPressed: () => onClickDownloadButton(),
              enabledObs: RxBool(true),
              style: BtnStyle.whiteOutlineRadius2,
            ),
          ],
        ),
      ),
    );
  }

  void onClickDownloadButton() {

  }
}