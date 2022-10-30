
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_dialog_container.dart';
import 'package:tmtt/src/screens/base/base_widget.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';


class HintDialog extends BaseWidget {

  late String email;
  late Function() onPayPressed;

  HintDialog({
    required this.email,
    required this.onPayPressed,
  });

  // @override
  // Widget build(BuildContext context) {
  //   return
  // }

  @override
  void onInit() {
  }

  @override
  Widget onBuild(BuildContext context) {
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
              onPayPressed();
            },
          ),
        ],
      ),
    );
  }
}