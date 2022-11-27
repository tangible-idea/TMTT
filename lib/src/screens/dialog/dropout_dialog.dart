
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/resources/styles/btn_style.dart';
import 'package:tmtt/src/screens/base/base_dialog_container.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text_field.dart';

class DropoutDialog extends StatelessWidget {

  Function() onConfirm;

  final _controller = TextEditingController();

  DropoutDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      title: "탈퇴하기",
      align: TextAlign.center,
      content: "'confirm'을 입력하고 '탈퇴하기'를 누르면 탈퇴됩니다.",
      child: Column(
        children: [
          PlainTextField(
            controller: _controller,
            hintText: "confirm",
          ),
          BottomPlainButton(
            text: "탈퇴하기",
            style: BtnStyle.negative,
            enabledObs: RxBool(true),
            onPressed: () => onPressedDropoutButton(),
          ),
        ],
      ),
    );
  }

  void onPressedDropoutButton() {
    if(_controller.text == "confirm") {
      onConfirm.call();
    }
  }

}
