
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/write_message/write_message_controller.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text.dart';
import 'package:tmtt/src/widgets/plain_text_field.dart';

class WriteMessageScreen extends GetView<WriteMessageController> {
  @override
  Widget build(BuildContext context) {
    controller.getUserId();
    return Obx(() => BaseScaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlainText(
              text: controller.userNameObs.value,
            ),
            PlainTextField(
              hintText: '메시지 입력하기',
              keyboardType: TextInputType.text,
              controller: controller.inputController,
            ),
            BottomPlainButton(
              text: '메시지 전송하기',
              onPressed: () => controller.writeMessage(),
              enabledObs: RxBool(true),
            )
          ],
        )
    ));
  }
}