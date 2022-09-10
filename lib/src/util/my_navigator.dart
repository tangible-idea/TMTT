import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyNav {
  static var _duration = const Duration(milliseconds: 350);

  static Future? push<T>({
    Widget? widget,
    Bindings? binding,
    dynamic? arguments
  }) {
    var result = Get.to(
      widget,
      transition: Transition.rightToLeft,
      duration: _duration,
      binding: binding,
      arguments: arguments,
    );
    return result;
  }

  static Future? pushNamed<T>({required String pageName, dynamic? arguments}) {
    var result = Get.toNamed(
      pageName,
      arguments: arguments,
    );
    return result;
  }

  static void pushReplacement(Widget widget) {
    Get.offAll(
      widget,
      transition: Transition.rightToLeft,
      duration: _duration,
    );
  }

  static void pushReplacementNamed({required String pageName, dynamic? arguments}) {
    Get.offAllNamed(
      pageName,
      arguments: arguments,
    );
  }

  static void pop<T>({T? result}) {
    Get.back(result: result);
  }

}
