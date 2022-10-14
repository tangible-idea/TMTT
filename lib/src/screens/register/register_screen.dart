
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/screens/base/base_app_bar.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/register/register_controller.dart';
import 'package:tmtt/src/util/app_space.dart';
import 'package:tmtt/src/util/my_logger.dart';
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpaces.verticalSpace40,

              // logo here
              Center(child: Image.asset(Assets.imagesTmttLogoWhite36)),
              AppSpaces.verticalSpace100,

              // explanation image
              SvgPicture.asset(Assets.imagesExplainationSocial),
              AppSpaces.verticalSpace40,

              const Text("Get anonymous messages on any kind of \r\n"+
                  "social media apps such as Instagram!"),

              AppSpaces.verticalSpace40,

              // social login buttons
              InkWell(child: SvgPicture.asset(Assets.imagesBtnLoginGoogle),),
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