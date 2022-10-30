import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/resources/styles/btn_style.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/screens/base/base_app_bar.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/base/base_widget.dart';
import 'package:tmtt/src/screens/inbox/inbox_controller.dart';
import 'package:tmtt/src/util/my_navigator.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/item_inbox_hero.dart';

import '../../widgets/plain_text.dart';

class InboxScreen extends GetView<InboxController> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'Messages',
        useBackButton: true,
        onBackPressed: () => MyNav.pop(),
      ),
      onPressedAosBackButton: () => MyNav.pop(),
      body: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InboxItem(
                  tag: 'TM${controller.getIndex()}',
                  isRead: true,
                  useMargin: false,
                  isPlay: true,
                  profileURL: controller.getProfile(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColor.kLightBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: MyColor.kPrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: PlainText(
                              text: controller.messageObs.value.question,
                              style: MyTextStyle.body.copyWith(
                                color: MyColor.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(24),
                            child: PlainText(
                              text: controller.messageObs.value.message,
                              style: MyTextStyle.body.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                BottomPlainButton(
                  text: '답장',
                  // onPressed: () => controller.goToHome(),
                  enabledObs: RxBool(true),
                ),
                BottomPlainButton(
                  text: '누가 보냈어',
                  onPressed: () => controller.onClickHint(),
                  enabledObs: RxBool(true),
                  style: BtnStyle.plain.copyWith(
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      return MyColor.kPink; // if (states.contains(MaterialState.pressed)) {}
                    }),
                  ),
                ),
              ]
      )),
    );
  }
}
