
import 'package:flutter/material.dart';
import 'package:tmtt/src/resources/styles/btn_style.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

class BottomTwoStackButton extends StatelessWidget {

  String? cancelText;
  String? confirmText;

  VoidCallback? onCancelPressed;
  VoidCallback? onConfirmPressed;

  BottomTwoStackButton({
    Key? key,
    this.cancelText,
    this.confirmText,
    this.onCancelPressed,
    this.onConfirmPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 6),
              child: TextButton(
                style: BtnStyle.gray,
                child: PlainText(
                  text: cancelText,
                  style: MyTextStyle.btn1.copyWith(color: MyColor.typo04),
                ),
                onPressed: () {
                  onCancelPressed?.call();
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 6),
              child: TextButton(
                style: BtnStyle.plain,
                child: PlainText(
                  text: confirmText,
                  style: MyTextStyle.btn1.copyWith(color: MyColor.white),
                ),
                onPressed: () {
                  onConfirmPressed?.call();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
