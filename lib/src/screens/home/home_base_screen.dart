
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
        appBar: BaseAppBar(
          title: controller.pageTitles[controller.currentIndexObs.value],
        ),
        onPressedAosBackButton: () {
          Log.d('onPressedAosBackButton');
        },
        body: controller.pages[controller.currentIndexObs.value],
        bottomNavigationBar: bottomNavigationBar()
    ));
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: MyColor.bg04,
      type: BottomNavigationBarType.fixed,
      currentIndex: controller.currentIndexObs.value,
      showSelectedLabels: true,
      selectedItemColor: MyColor.primary_05,
      onTap: (index) { controller.currentIndexObs.value = index; },
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
            label: "home"
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
            label: "inbox"
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
            label: "setting"
        ),
      ],
    );
  }
}
