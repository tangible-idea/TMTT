
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmtt_web/widgets/app_space.dart';
import 'package:tmtt_web/widgets/plain_text.dart';
import 'package:tmtt_web/write_message_controller.dart';

class MessageSendSuccessFragment extends GetView<WriteMessageController> {

  const MessageSendSuccessFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AppSpaces.verticalSpace20,
          Image.asset('assets/images/button_done.png', width: 210, height: 210),
          PlainText(
            text: "Your message has been sent\nanonymously!",
            align: TextAlign.center,
          )
        ],
      ),
    );
  }
}
