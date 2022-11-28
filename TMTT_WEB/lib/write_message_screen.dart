
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tmtt_web/widgets/download_advertise_item.dart';
import 'package:tmtt_web/write_message_controller.dart';

import 'base_scaffold.dart';
import 'constants/my_color.dart';
import 'my_navigator.dart';

class WriteMessageScreen extends GetView<WriteMessageController> {
  const WriteMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => BaseScaffold(
      resizeToAvoidBottomInset: false,
      onPressedAosBackButton: () => MyNav.pop(),
      backgroundColor: MyColor.kPrimary,
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 80),
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
              decoration: BoxDecoration(
                color: MyColor.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: controller.pages[controller.currentPageIndexObs.value],
                  ),
                  const DownloadAdvertiseItem(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: CircleAvatar(
                    radius: 50,
                    backgroundColor: MyColor.kLightBackground,
                    foregroundImage: NetworkImage(controller.userImageObs.value),
                ),
              ),
            ),
          ],
        )
    ));
  }
}

