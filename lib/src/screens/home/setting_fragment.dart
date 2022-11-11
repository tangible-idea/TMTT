
import 'dart:ui';

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

import '../../resources/languages/strings.dart';
import '../../resources/styles/btn_style.dart';
import '../../resources/styles/my_color.dart';
import '../../resources/styles/txt_style.dart';
import '../../widgets/setting_item.dart';

class SettingFragment extends GetView<HomeController> {



  @override
  Widget build(BuildContext context) {


    const double kItemExtent = 32.0;
    const List<String> languages = <String>[
      'Korean',
      'English',
      'Thai',
    ];
    const List<String> languageCodes = <String>[
      'ko',
      'en',
      'th',
    ];

    return FragmentContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          AppSpaces.verticalSpace20,

          InkWell(
              onTap: ()=> controller.openPrivacy(),
              child: SettingItem(title: Strings.settingFeedback1.tr, subtitle: Strings.settingFeedback2.tr, icon: Icons.feedback,)),

          InkWell(
              onTap: () => MyDialog.showCupertinoDialog(context,
                Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: MyColor.kLightBackground),
                          child: CupertinoPicker(
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: kItemExtent,
                          scrollController: FixedExtentScrollController(
                              initialItem: languageCodes.indexOf(Get.locale!.languageCode)
                          ),
                          // This is called when selected item is changed.
                          onSelectedItemChanged: (int selectedItem) {
                            //int indexOfLocale= languageCodes.indexOf(window.locale.languageCode);

                            //controller.changeAppLanguage(_languages[selectedItem].toString());
                            controller.focusedLang.value= languages[selectedItem].toString();
                          },
                          children: [
                              ...languages.map((e) => Text(e,
                                style: MyTextStyle.body16.copyWith(color: MyColor.kPrimary, fontSize: 28),
                              ))
                            ]
                          ),
                        ),
                      ),
                      BottomPlainButton(
                          text: "Select",
                          enabledObs: RxBool(true),
                          onPressed: () {
                              controller.changeAppLanguage();
                              Get.back();
                            },)
                    ],
                ), MyColor.kLightBackground),
              child: SettingItem(title: Strings.settingLanguage1.tr, subtitle: Strings.settingLanguage2.tr, icon: Icons.language,)
          ),


          // InkWell(
          //   onTap: () => controller.openPrivacy(),
          //   child: SettingItem(title: 'Invite your friends', subtitle: 'Invite your friends and get rewards.', icon: Icons.people,)),

          InkWell(
              onTap: () => controller.deactiveYourAccount(),
              child: SettingItem(title: Strings.settingDeactivate1.tr, subtitle: Strings.settingDeactivate2.tr, icon: Icons.delete,)),

          InkWell(
            onTap: () => controller.openPrivacy(),
              child: SettingItem(title: Strings.settingPrivacypolicy1.tr, subtitle: Strings.settingPrivacypolicy2.tr, icon: Icons.policy)),


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