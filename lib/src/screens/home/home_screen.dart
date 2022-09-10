
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_app_bar.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:tmtt/src/util/my_navigator.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text_field.dart';


class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        useBackButton: true,
        onBackPressed: () {
          Log.d('onBackPressed');
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
            hintText: '인스타 아이디 입력',
            keyboardType: TextInputType.text,
            controller: controller.inputController,
          ),
          const Spacer(),
          BottomPlainButton(
            text: '확인',
            onPressed: () => controller.getInputValue(),
            enabledObs: RxBool(true),
          )
        ],
      ),
    );
  }
}


