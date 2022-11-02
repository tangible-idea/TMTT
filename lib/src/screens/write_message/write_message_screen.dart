
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/write_message/write_message_controller.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';
import 'package:tmtt/src/widgets/plain_text_field.dart';

import '../../resources/styles/my_color.dart';
import '../../widgets/app_space.dart';
import '../../widgets/multiline_text_field.dart';

class WriteMessageScreen extends GetView<WriteMessageController> {
  @override
  Widget build(BuildContext context) {
    controller.getUserId();
    return Obx(() => BaseScaffold(
      backgroundColor: MyColor.kPrimary,
        body: Stack(
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 6),
              child: Container(
                decoration: BoxDecoration(
                  color: MyColor.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      AppSpaces.verticalSpace30,
                      Center(
                        child: PlainText(
                          align: TextAlign.center,
                          text: controller.userNameObs.value,
                          style: MyTextStyle.h2,
                        ),
                      ),
                      Center(
                        child: PlainText(
                          text: controller.userMessageObs.value,
                          style: MyTextStyle.body16.copyWith(color: MyColor.kGrey2),
                        ),
                      ),
                      AppSpaces.verticalSpace40,
                      MultiLineTextField(
                        maxLength: 100,
                        maxLine: 4,
                        hintText: 'Send me anonymouse message...',
                        controller: controller.inputController,
                      ),
                      BottomPlainButton(
                        icon: const Icon(Icons.send_rounded),
                        text: 'Send anonymously',
                        onPressed: () => controller.writeMessage(),
                        enabledObs: RxBool(true),
                      )
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                    radius: 50,
                    backgroundColor: MyColor.kLightBackground,
                    foregroundImage: CachedNetworkImageProvider(controller.userImageObs.value)),
              ),
            ),
          ],
        )
    ));
  }
}