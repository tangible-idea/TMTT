


import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tmtt/src/screens/share/share_controller.dart';

import '../../util/my_logger.dart';
import '../../widgets/bottom_button.dart';
import '../../widgets/plain_text.dart';
import '../../widgets/plain_text_field.dart';
import '../base/base_app_bar.dart';
import '../base/base_scaffold.dart';

class ShareScreen extends GetView<ShareController> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'custom app bar~~~~',
        useBackButton: true,
        useCancelButton: true,
        onBackPressed: () {
          Log.d('onBackPressed');
        },
        onCancelPressed: () {
          Log.d('onCancelPressed');
        },
      ),
      onPressedAosBackButton: () {
        Log.d('onPressedAosBackButton');
      },
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlainTextField(
            hintText: '공유할 내용 입력',
            keyboardType: TextInputType.text,
            controller: controller.inputController,
          ),
          Obx(() => PlainText(
            text: controller.textToShare.value,
          )),
          const Spacer(),
          BottomPlainButton(
            text: '공유',
            onPressed: () => controller.shareOnInstagram(),
            enabledObs: RxBool(true),
          )
        ],
      ),
    );
  }
}

