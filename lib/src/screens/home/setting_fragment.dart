
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_fragment_container.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
import 'package:tmtt/src/widgets/app_space.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

import '../../resources/styles/txt_style.dart';
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

          AppSpaces.verticalSpace20,

          InkWell(
              onTap: ()=> controller.openPrivacy(),
              child: SettingItem(title: 'Feedback', subtitle: 'Report technical issues\nor suggest new features.', icon: Icons.feedback,)),

          InkWell(
            onTap: () => controller.openPrivacy(),
            child: SettingItem(title: 'Invite your friends', subtitle: 'Invite your friends and get rewards.', icon: Icons.people,)),


          InkWell(
              onTap: () => controller.openPrivacy(),
              child: SettingItem(title: 'Deactivate your account', subtitle: 'This cannot be undone.', icon: Icons.delete,)),

          InkWell(
            onTap: () => controller.openPrivacy(),
              child: SettingItem(title: 'Privacy policy', subtitle: 'Read privacy policy of TMTT', icon: Icons.policy)),


          const Spacer(),
          Center(child: InkWell(
            onTap: ()=> controller.signOut(),
              child: PlainText(text: "Log out", style: MyTextStyle.body16bold.copyWith(color: Colors.redAccent)))),
          AppSpaces.verticalSpace60,
          // BottomPlainButton(
          //   text: 'Change your slug',
          //   onPressed: () => controller.recreateYourSulg(),
          //   enabledObs: RxBool(true),
          // ),


        ],
      ),
    );
  }
}