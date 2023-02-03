
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/write_message/message_input_fragment.dart';
import 'package:tmtt/src/screens/write_message/write_message_controller.dart';
import 'package:tmtt/src/util/my_navigator.dart';
import 'package:tmtt/src/widgets/app_space.dart';
import 'package:tmtt/src/widgets/download_advertise_item.dart';

import '../../../generated/assets.dart';
import '../../resources/styles/my_color.dart';

class WriteMessageScreen extends GetView<WriteMessageController> {
  const WriteMessageScreen({super.key});

  // Expanded(
  // child: controller.pages[controller.currentPageIndexObs.value],
  // ),
  // const DownloadAdvertiseItem(),


  // CircleAvatar(
  // radius: 50,
  // backgroundColor: MyColor.kLightBackground,
  // foregroundImage: NetworkImage(controller.userImageObs.value),
  // ),

  @override
  Widget build(BuildContext context) {
    return Obx(() => BaseScaffold(
      resizeToAvoidBottomInset: false,
      onPressedAosBackButton: () => MyNav.pop(),
      backgroundColor: MyColor.kNewBackground,
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              repeat: ImageRepeat.repeat,
              image: AssetImage(Assets.imagesQuestionBackground),
              fit: BoxFit.none,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: controller.pages[controller.currentPageIndexObs.value]),
              //AppSpaces.verticalSpace20,
            ],
          ),
        )
    ));
  }
}

