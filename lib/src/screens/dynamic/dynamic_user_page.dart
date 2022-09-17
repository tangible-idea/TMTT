
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/dynamic/dynamic_user_controller.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

class DynamicUserScreen extends GetView<DynamicUserController> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlainText(
              text: controller.getUserId(),
            ),
          ],
        )
    );
  }
}