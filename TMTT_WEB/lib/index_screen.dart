
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt_web/widgets/plain_text.dart';

import 'base_scaffold.dart';
import 'index_controller.dart';

class IndexScreen extends GetView<IndexController> {

  @override
  Widget build(BuildContext context) {
    controller.getDeviceInfoTest();
    return Obx(() => BaseScaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PlainText(
            //   text: 'index page. 앱 소개 페이지를 여기에 만들면 좋을듯',
            // ),
            PlainText(
              text: 'index page\n'
                  '${controller.infoObs.value}',
            ),
            PlainText(
              marginTop: 24,
              text: 'instaInfo\n'
                  '${controller.instaInfoObs.value}',
            ),
            controller.instaProfilePictureObs.value.isEmpty ?
            Container() :
            Image.network(controller.instaProfilePictureObs.value),
          ],
        )
    ));
  }
}
