
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
import '../../widgets/plain_text.dart';
import '../../widgets/plain_text_field.dart';

class CreateSlugScreen extends GetView<RegisterController> {


  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
    backgroundColor: MyColor.kLightBackground,
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
              Center(child: Image.asset(Assets.imagesTmttLogoBlack36)),
              AppSpaces.verticalSpace50,

              const Text("this web address is how people will find\r\n"
                  "your TMTT profile online.",
                  style: MyTextStyle.body,
                  textAlign: TextAlign.center),
              AppSpaces.verticalSpace40,

              PlainTextField(
                hintText: 'https://tmtt.link/',
                keyboardType: TextInputType.text,
                controller: controller.slugInputController,
              ),

              AppSpaces.verticalSpace10,

              BottomPlainButton(
                text: 'Check',
                onPressed: () => controller.createYourSlug(controller.slugInputController.text),
                enabledObs: RxBool(true),
              ),
            ]
        ),
    );
  }
}