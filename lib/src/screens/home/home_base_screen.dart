
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/screens/base/base_app_bar.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
import 'package:tmtt/src/util/my_logger.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => BaseScaffold(
        appBar: controller.useHeaderObs.value ?
        BaseAppBar(
          title: controller.pageTitles[controller.currentPageIndexObs.value],
        ): null,
        paddingState: PaddingState.noPadding,
        useSafeAreaTop: controller.useHeaderObs.value,
        onPressedAosBackButton: () {
          Log.d('onPressedAosBackButton');
        },
        body: controller.pages[controller.currentPageIndexObs.value],
        bottomNavigationBar: bottomNavigationBar()
    ));
  }

  BottomNavigationBar newBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: MyColor.bg04,
      type: BottomNavigationBarType.fixed,
      currentIndex: controller.currentPageIndexObs.value,
      showSelectedLabels: true,
      selectedItemColor: MyColor.primary_05,
      onTap: (index) {
        controller.currentPageIndexObs.value = index;
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: MyColor.gray_01,
            ),
            activeIcon: Icon(
              Icons.home,
              color: MyColor.primary_05,
            ),
            label: 'tmtt'
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.photo,
              color: MyColor.gray_01,
            ),
            activeIcon: Icon(
              Icons.photo,
              color: MyColor.primary_05,
            ),
            label: 'inbox'
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.mail_outline,
              color: MyColor.gray_01,
            ),
            activeIcon: Icon(
              Icons.mail_outline,
              color: MyColor.primary_05,
            ),
            label: 'others'
        ),
      ],
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: MyColor.bg04,
      type: BottomNavigationBarType.fixed,
      currentIndex: controller.currentPageIndexObs.value,
      showSelectedLabels: true,
      selectedItemColor: MyColor.primary_05,
      onTap: (index) {
        controller.currentPageIndexObs.value = index;
        controller.useHeaderObs.value = index != 0;
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: MyColor.gray_01,
            ),
            activeIcon: Icon(
              Icons.home,
              color: MyColor.primary_05,
            ),
            label: 'Share'
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.photo,
              color: MyColor.gray_01,
            ),
            activeIcon: Icon(
              Icons.photo,
              color: MyColor.primary_05,
            ),
            label: 'Messages'
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.mail_outline,
              color: MyColor.gray_01,
            ),
            activeIcon: Icon(
              Icons.mail_outline,
              color: MyColor.primary_05,
            ),
            label: 'others'
        ),
      ],
    );
  }
}
