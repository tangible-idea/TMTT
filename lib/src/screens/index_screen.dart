
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/base/base_widget.dart';
import 'package:tmtt/src/util/my_navigator.dart';
import 'package:tmtt/pages.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

import 'index_controller.dart';

class IndexScreen extends GetView<IndexController> {

  @override
  Widget build(BuildContext context) {
    controller.getDeviceInfoTest();
    return BaseScaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PlainText(
            //   text: 'index page. 앱 소개 페이지를 여기에 만들면 좋을듯',
            // ),
            Obx(() => PlainText(
              text: 'index page\n'
                  '${controller.infoObs.value}',
            )),
          ],
        )
    );
  }
}
