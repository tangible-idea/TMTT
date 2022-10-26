
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/resources/styles/btn_style.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

class WhiteButton extends StatelessWidget {

  String? text;
  VoidCallback? onPressed;
  double? fontSize;
  Widget? icon;

  RxBool enabledObs = true.obs;

  WhiteButton({
    Key? key,
    this.text,
    this.onPressed,
    this.fontSize,
    this.icon,
    required this.enabledObs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Obx(() => setButtonState(enabledObs.value)),
        ],
      ),
    );
  }

  var normalButtonStyle= BtnStyle.whiteOutlineRadius;
  var disabledButtonStyle= BtnStyle.whiteOutlineRadius;

  Widget setButtonState(bool isEnable) {
      return icon == null ? OutlinedButton(
        style: isEnable ? normalButtonStyle : disabledButtonStyle,
        child: PlainText(
          text: text,
          style: TextStyle(
            fontSize: fontSize ?? 12,
            color: MyColor.black,
          ),
        ),
        onPressed: () {
          onPressed?.call();
        },
      ) : OutlinedButton.icon(
        icon: icon!.marginOnly(left: 12),
        style: isEnable ? normalButtonStyle : disabledButtonStyle,
        label: PlainText(
          text: text,
          style: TextStyle(
            fontSize: fontSize ?? 13,
            color: MyColor.black,
          ),
        ),
        onPressed: () {
          onPressed?.call();
        },
      );
  }
}
