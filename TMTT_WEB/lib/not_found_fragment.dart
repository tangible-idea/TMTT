
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt_web/widgets/plain_text.dart';
import 'package:tmtt_web/write_message_controller.dart';

class NotFoundUserFragment extends GetView<WriteMessageController> {

  const NotFoundUserFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          PlainText(
            marginTop: 10,
            text: "user not found!",
            align: TextAlign.center,
          )
        ],
      ),
    );
  }
}
