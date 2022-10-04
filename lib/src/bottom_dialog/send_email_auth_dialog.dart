
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_dialog_container.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';


class SendEmailAuthDialog extends StatelessWidget {

  late String email;
  late Function() onTermsPressed;
  late Function() onNextPressed;

  SendEmailAuthDialog({
    required this.email,
    required this.onTermsPressed,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BottomDialogContainer(
      child: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomPlainButton(
            text: 'ㅁㄴㅇㅁㄴㅇㅁㄴ',
            enabledObs: RxBool(true),
            onPressed: () {
              Get.back();
              onNextPressed();
              // controller.onNextPressed();
            },
          ),
        ],
      ),
    );
  }
}