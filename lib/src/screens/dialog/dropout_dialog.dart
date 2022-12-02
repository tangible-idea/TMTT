
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/resources/styles/btn_style.dart';
import 'package:tmtt/src/screens/base/base_dialog_container.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text_field.dart';

import '../../resources/languages/strings.dart';

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
      title: Strings.settingDeactivate1.tr,
      align: TextAlign.center,
      content: Strings.settingDeactivate3.tr,
      child: Column(
        children: [
          PlainTextField(
            controller: _controller,
            hintText: "confirm",
          ),
          BottomPlainButton(
            text: Strings.settingDeactivate4.tr,
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
