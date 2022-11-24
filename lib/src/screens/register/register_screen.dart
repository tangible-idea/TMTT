
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
import 'package:tmtt/src/widgets/app_space.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:tmtt/src/util/my_snackbar.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

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
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // logo here
              Center(child: Image.asset(Assets.imagesTmttLogoWhite36)),
              AppSpaces.verticalSpace90,

              // explanation image
              SvgPicture.asset(Assets.imagesExplainationSocial),
              AppSpaces.verticalSpace20,

              PlainText(
                text: Strings.registerDesc1.tr,
                style: MyTextStyle.body.copyWith(
                  color: Colors.white,
                ),
                align: TextAlign.center
              ),
              AppSpaces.verticalSpace40,

              // social login buttons
              InkWell(onTap: () async {
                  controller.signInWithGoogle();
                },
                child: SvgPicture.asset(Assets.imagesBtnLoginGoogle),
              ),

              AppSpaces.verticalSpace10,
              GetPlatform.isIOS ? InkWell(onTap: () async {
                controller.signInWithApple();
              },
                child: SvgPicture.asset(Assets.imagesBtnLoginApple),
              ): const SizedBox(),

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
      ),
    );
  }
}