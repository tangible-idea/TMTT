
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
  double? fontSize;
  Widget? icon;

  RxBool enabledObs = true.obs;

  BottomPlainButton({
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

  var normalButtonStyle= BtnStyle.plain.copyWith(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(18)
    ),
  );

  var disabledButtonStyle= BtnStyle.disabledPlain.copyWith(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(18)
    ),
  );

  Widget setButtonState(bool isEnable) {
      return icon == null ? ElevatedButton(
        style: isEnable ? normalButtonStyle : disabledButtonStyle,
        child: PlainText(
          text: text,
          style: TextStyle(
            fontSize: fontSize ?? 16,
            color: MyColor.white,
          ),
        ),
        onPressed: () {
          onPressed?.call();
        },
      ) : ElevatedButton.icon(
        icon: icon!,
        style: isEnable ? normalButtonStyle : disabledButtonStyle,
        label: PlainText(
          text: text,
          style: TextStyle(
            fontSize: fontSize ?? 16,
            color: MyColor.white,
          ),
        ),
        onPressed: () {
          onPressed?.call();
        },
      );
  }
}
