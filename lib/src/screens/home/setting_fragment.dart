
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_fragment_container.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

class SettingFragment extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    controller.getDeviceInfoTest();
    return FragmentContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlainText(
            text: 'SettingFragment',
          ),
          Obx(() => PlainText(
            text: controller.deviceInfoObs.value,
          )),
          const Spacer(),
          BottomPlainButton(
            text: 'privacy',
            onPressed: () => controller.openPrivacy(),
            enabledObs: RxBool(true),
          ),
        ],
      ),
    );
  }
}