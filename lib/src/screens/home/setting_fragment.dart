
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/src/screens/base/base_fragment_container.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
import 'package:tmtt/src/util/my_dialog.dart';
import 'package:tmtt/src/widgets/app_space.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

import '../../resources/styles/btn_style.dart';
import '../../resources/styles/my_color.dart';
import '../../resources/styles/txt_style.dart';
import '../../widgets/setting_item.dart';

class SettingFragment extends GetView<HomeController> {



  @override
  Widget build(BuildContext context) {

    const double _kItemExtent = 32.0;
    const List<String> _languages = <String>[
      'Korean',
      'English',
      'Thai',
    ];

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
              onTap: () => MyDialog.showCupertinoDialog(context,
                CupertinoPicker(
                magnification: 1.22,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: _kItemExtent,
                // This is called when selected item is changed.
                onSelectedItemChanged: (int selectedItem) {
                  controller.changeAppLanguage(_languages[selectedItem].toString());
                },
                children:
                List<Widget>.generate(_languages.length, (int index) {
                  return Center(
                    child: Text(
                      _languages[index],
                    ),
                  );
                }),
              ),),
              child: SettingItem(title: 'Language', subtitle: 'Change your app language.', icon: Icons.language,)),


          // InkWell(
          //   onTap: () => controller.openPrivacy(),
          //   child: SettingItem(title: 'Invite your friends', subtitle: 'Invite your friends and get rewards.', icon: Icons.people,)),

          InkWell(
              onTap: () => controller.deactiveYourAccount(),
              child: SettingItem(title: 'Deactivate your account', subtitle: 'This cannot be undone.', icon: Icons.delete,)),

          InkWell(
            onTap: () => controller.openPrivacy(),
              child: SettingItem(title: 'Privacy policy', subtitle: 'Read privacy policy of TMTT', icon: Icons.policy)),


          const Spacer(),
          Center(child: InkWell(
            onTap: ()=> controller.signOut(),
              child: PlainText(text: "Log out", style: MyTextStyle.body16bold.copyWith(color: Colors.redAccent)))),
          const Spacer(),

          kDebugMode ?
          Column(
            children: [
              BottomPlainButton(
                text: 'Change your slug [debug mode]',
                onPressed: () => controller.recreateYourSulg(),
                enabledObs: RxBool(true),
              ),
              BottomPlainButton(
                text: 'Download insta photo [debug mode]',
                onPressed: () => controller.downloadInstagramProfile(),
                enabledObs: RxBool(true),
              ),
              BottomPlainButton(
                text: 'write message [debug mode]',
                onPressed: () => controller.startWhiteMessageTest(),
                enabledObs: RxBool(true),
              ),
            ],
          ) : const SizedBox()


        ],
      ),
    );
  }
}