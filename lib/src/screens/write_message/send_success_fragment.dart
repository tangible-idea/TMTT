
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/screens/write_message/write_message_controller.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

class MessageSendSuccessFragment extends GetView<WriteMessageController> {

  const MessageSendSuccessFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Lottie.asset(
                Assets.lottieCheck,
                repeat: false,
                width: 210,
                height: 210,
              ),
            ),
          ),
          PlainText(
            text: "Your message has been sent\nanonymously!",
            align: TextAlign.center,
          )
        ],
      ),
    );
  }
}
