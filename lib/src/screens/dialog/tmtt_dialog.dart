
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_dialog_container.dart';
import 'package:tmtt/src/widgets/bottom_two_stack_button.dart';

import '../../widgets/bottom_button.dart';

class TMTTDialog extends StatelessWidget {

  String? title;
  String? content;

  String? cancelText;
  String? confirmText;

  Function() onCancelPressed;
  Function() onConfirmPressed;

  TMTTDialog({
    this.title,
    this.content,
    this.cancelText,
    this.confirmText,
    required this.onCancelPressed,
    required this.onConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      title: title ?? '',
      align: TextAlign.center,
      content: content ?? '',
      child: BottomTwoStackButton(
        cancelText: cancelText,
        confirmText: confirmText,
        onCancelPressed: () => Get.back(),
        onConfirmPressed: () => onConfirmPressed(),
      ),
    );
  }
}


class PlainSimpleDialog extends StatelessWidget {

  String? title;
  String? content;

  String? confirmText;

  Function() onConfirmPressed;

  TextAlign? align;

  PlainSimpleDialog({
    this.title,
    this.content,
    this.confirmText,
    this.align,
    required this.onConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      title: title ?? '',
      content: content ?? '',
      child: BottomPlainButton(
        text: confirmText,
        enabledObs: RxBool(true),
        onPressed: () => onConfirmPressed(),
      ),
    );
  }
}