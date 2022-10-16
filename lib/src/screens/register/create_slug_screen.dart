
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

import '../../../generated/assets.dart';
import '../../widgets/plain_text.dart';
import '../../widgets/plain_text_field.dart';
import '../../widgets/prefix_text_field.dart';

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

              Text(Strings.registerDesc2.tr,
                  style: MyTextStyle.body,
                  textAlign: TextAlign.center),
              AppSpaces.verticalSpace10,
              Text("(For example, your instagram ID.)",
                  style: MyTextStyle.body.copyWith(color: Colors.black38),
                  textAlign: TextAlign.center),
              AppSpaces.verticalSpace30,

              Obx(() =>
                PrefixInputField(
                  prefixString: 'https://tmtt.link/',
                  hintText: 'tmtt.link',
                  keyboardType: TextInputType.text,
                  controller: controller.slugInputController,
                  errorValidation: controller.errorObs.value,
                  maxLength: 16,
                ),
              ),

              AppSpaces.verticalSpace10,

              BottomPlainButton(
                text: Strings.registerCreateYourOwnLInk.tr,
                onPressed: () => controller.createYourSlug(controller.slugInputController.text),
                enabledObs: RxBool(true),
              ),
            ]
        ),
    );
  }
}