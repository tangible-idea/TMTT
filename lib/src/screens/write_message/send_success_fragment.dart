
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/screens/write_message/write_message_controller.dart';
import 'package:tmtt/src/widgets/app_space.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

class MessageSendSuccessFragment extends GetView<WriteMessageController> {

  const MessageSendSuccessFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AppSpaces.verticalSpace20,
          Image.asset(Assets.imagesButtonDone, width: 210, height: 210),
          PlainText(
            text: "Your message has been sent\nanonymously!",
            align: TextAlign.center,
          )
        ],
      ),
    );
  }
}
