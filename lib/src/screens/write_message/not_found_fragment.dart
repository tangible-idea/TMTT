
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/screens/write_message/write_message_controller.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

class NotFoundUserFragment extends GetView<WriteMessageController> {

  const NotFoundUserFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Lottie.asset(
              Assets.lottieEmptyMessage,
              // repeat: false,
              width: 300,
              height: 300,
            ),
          ),
          PlainText(
            text: "user not found!",
            align: TextAlign.center,
          )
        ],
      ),
    );
  }
}
