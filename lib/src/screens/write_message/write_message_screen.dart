
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/write_message/message_input_fragment.dart';
import 'package:tmtt/src/screens/write_message/write_message_controller.dart';
import 'package:tmtt/src/util/my_navigator.dart';
import 'package:tmtt/src/widgets/download_advertise_item.dart';

import '../../resources/styles/btn_style.dart';
import '../../resources/styles/my_color.dart';
import '../../resources/styles/txt_style.dart';
import '../../widgets/bottom_button.dart';

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
                  BottomPlainButton(
                    text: 'Get my own message!',
                    textStyle: MyTextStyle.body2Bold.copyWith(color: MyColor.kPrimary,),
                    onPressed: () => controller.onClickDownloadButton(),
                    enabledObs: RxBool(true),
                    style: BtnStyle.whiteOutlineRadius2)
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

