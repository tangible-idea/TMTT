
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/screens/base/base_fragment_container.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
import 'package:tmtt/src/widgets/item_inbox_hero.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

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
            child: ListView.builder(
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
        tag: 'TM$index',
        isRead: data.read,
        profileURL: controller.profileURL.value,
      ),
    );
  }
}