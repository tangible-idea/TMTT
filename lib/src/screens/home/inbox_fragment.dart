
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/screens/base/base_fragment_container.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
import 'package:tmtt/src/widgets/app_space.dart';
import 'package:tmtt/src/widgets/item_inbox_hero.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

import '../../../generated/assets.dart';

class InboxFragment extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    controller.getMyMessages();
    return FragmentContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Expanded(
            child: controller.messagesObs.value.isEmpty ?
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 30),
                  child: Column(
                    children: [
                      Lottie.asset(Assets.lottieEmptyMessage),
                      AppSpaces.verticalSpace20,
                      Center(child: PlainText(text: "It's empty here", style: MyTextStyle.h2,)),
                      AppSpaces.verticalSpace10,
                      Center(child: PlainText(text: "Did you share your message\nto your followers?",
                          style: MyTextStyle.body16.copyWith(color: MyColor.kGrey2),
                          align: TextAlign.center)),
                      AppSpaces.verticalSpace40
                    ],
                  ),
                )
                : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.messagesObs.value.length,
              itemBuilder: (BuildContext buildContext, int index) {
                return messageItem(index, controller.messagesObs.value[index]);
              },
            ),
          )),
        ],
      ),
    );
  }

  Widget messageItem(int index, Message data) {
    return InkWell(
      onTap: () => controller.onClickMessage(index, data),
      child: InboxItem(
        tag: "TM$index",
        data: data.docId.substring(0, 3).toUpperCase(),
        isRead: data.read,
        profileURL: controller.profileURL.value,
      ),
    );
  }
}