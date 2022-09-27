
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/write_message/write_message_controller.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

class DynamicUserScreen extends GetView<WriteMessageController> {
  @override
  Widget build(BuildContext context) {
    controller.getUserId();
    return BaseScaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => PlainText(
              text: controller.userNameObs.value,
            )),
          ],
        )
    );
  }
}