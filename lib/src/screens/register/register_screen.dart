
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_app_bar.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/register/register_controller.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';

import '../../widgets/plain_text.dart';
import '../../widgets/plain_text_field.dart';

class RegisterScreen extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'register screen',
        useBackButton: true,
        useCancelButton: true,
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
            PlainTextField(
              hintText: '인스타그램 아이디',
              keyboardType: TextInputType.text,
              controller: controller.inputController,
            ),
            PlainText(
              text: "",
            ),
            const Spacer(),
            BottomPlainButton(
              text: '확인',
              onPressed: () => controller.register(),
              enabledObs: RxBool(true),
            ),
          ]
      ),
    );
  }
}