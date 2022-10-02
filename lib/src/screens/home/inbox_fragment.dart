
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/screens/base/base_fragment_container.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
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
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(controller.messagesObs.value.length, (index) {
                return messageItem(controller.messagesObs.value[index]);
              }),
            ),
          )),
        ],
      ),
    );
  }

  Widget messageItem(Message data) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(4),
      color: MyColor.bg04,
      child: Center(
        child: PlainText(
          text: 'Item ${data.createDate}',
        ),
      ),
    );
  }
}