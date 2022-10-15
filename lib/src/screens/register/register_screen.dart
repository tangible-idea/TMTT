
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tmtt/src/resources/languages/strings.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/screens/base/base_app_bar.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/register/register_controller.dart';
import 'package:tmtt/src/util/app_space.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:tmtt/src/util/my_snackbar.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';

import '../../../generated/assets.dart';

class RegisterScreen extends GetView<RegisterController> {


  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
    backgroundColor: MyColor.kPrimary,
      appBar: BaseAppBar(
        onBackPressed: () {
          Log.d('onBackPressed');
        },
        onCancelPressed: () {
          Log.d('onCancelPressed');
        },
      ),
      onPressedAosBackButton: () {
        Log.d('onPressedAosBackButton');
      },
      body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // logo here
              Center(child: Image.asset(Assets.imagesTmttLogoWhite36)),
              AppSpaces.verticalSpace90,

              // explanation image
              SvgPicture.asset(Assets.imagesExplainationSocial),
              AppSpaces.verticalSpace20,

              Text(Strings.registerDesc1.tr,
                style: MyTextStyle.body.copyWith(color: Colors.white),
                textAlign: TextAlign.center),
              AppSpaces.verticalSpace40,

              // social login buttons
              InkWell(onTap: () async {
                  controller.signInWithGoogle();
                },
                child: SvgPicture.asset(Assets.imagesBtnLoginGoogle),
              ),

              AppSpaces.verticalSpace10,
              SvgPicture.asset(Assets.imagesBtnLoginFacebook),

              // BottomPlainButton(
              //   text: '확인',
              //   onPressed: () => controller.register(),
              //   enabledObs: RxBool(true),
              // ),
              // BottomPlainButton(
              //   text: '홈으로 테스트',
              //   onPressed: () => controller.goToHome(),
              //   enabledObs: RxBool(true),
              // ),
            ]
        ),
    );
  }
}