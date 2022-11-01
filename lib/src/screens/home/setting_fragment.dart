
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_fragment_container.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

import '../../widgets/setting_item.dart';

class SettingFragment extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    controller.getDeviceInfoTest();
    return FragmentContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Obx(() => PlainText(
          //   text: controller.deviceInfoObs.value,
          // )),

          SettingItem(title: 'Feedback', subtitle: 'send your feedback',),
          SettingItem(title: 'Deactivate your account', subtitle: 'send your feedback',),
          SettingItem(title: 'Privacy policy', subtitle: 'send your feedback',),

          const Spacer(),
          BottomPlainButton(
            text: 'Change your slug',
            onPressed: () => controller.recreateYourSulg(),
            enabledObs: RxBool(true),
          ),
          BottomPlainButton(
            text: 'Sign out',
            onPressed: () => controller.signOut(),
            enabledObs: RxBool(true),
          ),
          BottomPlainButton(
            text: 'Privacy Policy',
            onPressed: () => controller.openPrivacy(),
            enabledObs: RxBool(true),
          ),
        ],
      ),
    );
  }
}