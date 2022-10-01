
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_fragment_container.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';
import 'package:tmtt/src/widgets/plain_text_field.dart';

class HomeFragment extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return FragmentContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlainTextField(
            hintText: '인스타 아이디 입력',
            keyboardType: TextInputType.text,
            controller: controller.inputController,
          ),
          Obx(() => PlainText(
            text: controller.userNameObs.value,
          )),
          const Spacer(),
          BottomPlainButton(
            text: '인스타에 공유하기',
            onPressed: () => controller.shareOnInstagram(context),
            enabledObs: RxBool(true),
          ),
          BottomPlainButton(
            text: '확인',
            onPressed: () => controller.searchInstaUser(),
            enabledObs: RxBool(true),
          )
        ],
      ),
    );
  }
}