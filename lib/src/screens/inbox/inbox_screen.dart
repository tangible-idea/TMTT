
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
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
        title: 'inbox screen',
        useBackButton: true,
        onBackPressed: () => MyNav.pop(),
      ),
      onPressedAosBackButton: () =>MyNav.pop(),
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
            PlainText(
              text: 'question: ${controller.messageObs.value.question}\n'
                  'message: ${controller.messageObs.value.message}',
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
            ),
          ]
      )),
    );
  }
}

