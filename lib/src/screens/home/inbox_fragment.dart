
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tmtt/data/model/message.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/screens/base/base_fragment_container.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:tmtt/src/widgets/app_space.dart';
import 'package:tmtt/src/widgets/common/custom_widget.dart';
import 'package:tmtt/src/widgets/item_inbox_hero.dart';
import 'package:tmtt/src/widgets/plain_text.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';


import '../../../generated/assets.dart';
import '../../resources/languages/strings.dart';

class InboxFragment extends GetView<HomeController> {
  const InboxFragment({super.key});

  Widget messageMainContents() {
    return CustomRefreshIndicator(
      onRefresh: () async {
        Log.d('refresh!');
        controller.onRefreshMyMessage();
      },
      builder: MaterialIndicatorDelegate(
        builder: (context, controller) {
          return Image.asset(Assets.imagesSplashLogo);
        },
      ),
      child: ListView.builder(
        controller: controller.inboxScrollController,
        scrollDirection: Axis.vertical,
        itemCount: controller.messagesObs.value.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return messageItem(index, controller.messagesObs.value[index]);
        },
      ),
    );
  }

  Widget getSingleListShimmer() {
   return const Padding(
     padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
     child: CustomWidget.rectangular(width: 500, height: 100),
   );
  }

  // on loading -> shimmering, after loading -> show contents or empty status.
  Widget showShimmeringWhileLoadingMessage() {
    if(controller.isLoadingMyMessages.value) {
      return ListView(
        children: [
          getSingleListShimmer(),
          getSingleListShimmer(),
          getSingleListShimmer(),
          getSingleListShimmer(),
          getSingleListShimmer(),
          getSingleListShimmer(),
          getSingleListShimmer(),
        ],
      );
    }else{ // 로딩이 완료되었는데 없다면 empty 표시.
      return controller.messagesObs.value.isEmpty ?
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 30),
          child: Column(
            children: [
              Lottie.asset(Assets.lottieEmptyMessage),
              AppSpaces.verticalSpace20,
              Center(child: PlainText(text: Strings.messageEmptyState.tr, style: MyTextStyle.h2,)),
              AppSpaces.verticalSpace10,
              Center(child: PlainText(text: Strings.messageEmptyStateBody.tr,
                  style: MyTextStyle.body16.copyWith(color: MyColor.kGrey2),
                  align: TextAlign.center)),
              AppSpaces.verticalSpace40
            ],
          ),
        ) : messageMainContents();
    }
  }

  @override
  Widget build(BuildContext context) {

    controller.getMyMessages();

    return FragmentContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Expanded(
            child: showShimmeringWhileLoadingMessage()
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