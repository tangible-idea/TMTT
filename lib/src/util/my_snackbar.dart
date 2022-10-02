

import 'package:get/get.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';

class MySnackBar {

  static void show({
    String? title = '',
    String? message = '',
  }) {
    Get.snackbar(
      title ?? '',
      message ?? '',
      barBlur: 30,
      colorText: MyColor.white,
      backgroundColor: MyColor.gray_06,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      animationDuration: const Duration(milliseconds: 350),
    );
  }
}