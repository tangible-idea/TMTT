
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/resources/styles/btn_style.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

class BottomGrayButton extends StatelessWidget {

  String? text;
  VoidCallback? onPressed;
  RxBool enabledObs = true.obs;

  BottomGrayButton({
    Key? key,
    this.text,
    this.onPressed,
    required this.enabledObs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => setButtonState(enabledObs.value)),
          ),
        ],
      ),
    );
  }

  Widget setButtonState(bool isEnable) {
    if (isEnable) {
      return TextButton(
        style: BtnStyle.gray.copyWith(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(18)
          ),
        ),
        child: PlainText(text: text),
        onPressed: () {
          onPressed?.call();
        },
      );
    } else {
      return TextButton(
        style: BtnStyle.gray.copyWith(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(18)
          ),
        ),
        onPressed: null,
        child: PlainText(text: text),
      );
    }
  }
}


class BottomPlainButton extends StatelessWidget {

  String? text;
  VoidCallback? onPressed;

  RxBool enabledObs = true.obs;

  BottomPlainButton({
    Key? key,
    this.text,
    this.onPressed,
    required this.enabledObs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => setButtonState(enabledObs.value)),
          ),
        ],
      ),
    );
  }

  Widget setButtonState(bool isEnable) {
    if (isEnable) {
      return TextButton(
        style: BtnStyle.plain.copyWith(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(18)
          ),
        ),
        child: PlainText(
          text: text,
          style: const TextStyle(
            color: MyColor.white,
          ),
        ),
        onPressed: () {
          onPressed?.call();
        },
      );
    } else {
      return TextButton(
        style: BtnStyle.disabledPlain.copyWith(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(18)
          ),
        ),
        onPressed: null,
        child: PlainText(
          text: text,
          style: const TextStyle(
            color: MyColor.white,
          ),
        ),
      );
    }
  }
}
