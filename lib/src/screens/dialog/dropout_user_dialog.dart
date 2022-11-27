
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/resources/styles/btn_style.dart';
import 'package:tmtt/src/screens/base/base_dialog_container.dart';
import 'package:tmtt/src/util/my_navigator.dart';
import 'package:tmtt/src/widgets/bottom_button.dart';
import 'package:tmtt/src/widgets/plain_text_field.dart';

class DropoutUserDialog extends StatelessWidget {

  DropoutUserDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      title: "당신은 탈퇴한 유저입니다",
      align: TextAlign.center,
      content: "다시 사용하길 원하시면 'help@tmtt.link'로 문의주세요",
      child: BottomPlainButton(
        text: "확인",
        style: BtnStyle.negative,
        enabledObs: RxBool(true),
        onPressed: () => MyNav.pop(),
      ),
    );
  }
}
