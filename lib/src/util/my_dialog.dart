
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/dialog/plain_dialog.dart';

import '../resources/languages/strings.dart';

class MyDialog {

  static void showBottom({
        required Widget widget,
        bool isCancelable = true,
        bool isFullScreen = false
      }) {
    Get.bottomSheet(
      widget,
      enableDrag: isCancelable,
      isScrollControlled: isFullScreen,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
    );
  }

  static void show(
      Widget widget, {
        bool isCancelable = true,
        bool isFullScreen = false
      }) {
    Get.dialog(
      widget,
      transitionDuration: const Duration(milliseconds: 250),
    );
  }

  static void showPlain({
    String? title = '',
    String? content = '',
    String? cancelText = '닫기',
    String? confirmText = '확인',
    Function()? onCancelPressed,
    Function()? onConfirmPressed
  }) {
    var widget = PlainDialog(
      title: title,
      content: content,
      cancelText: cancelText,
      confirmText: confirmText,
      onCancelPressed : () {
        if(onCancelPressed != null) {
          onCancelPressed();
        }
      },
      onConfirmPressed: () {
        if(onConfirmPressed != null) {
          onConfirmPressed();
        }
      },
    );
    Get.dialog(
      widget,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  static void showPlainSimple({
    String? title = '',
    String? content = '',
    String? confirmText = '확인',
    TextAlign? align = TextAlign.center,
    Function()? onConfirmPressed
  }) {
    var widget = PlainSimpleDialog(
      title: title,
      content: content,
      confirmText: confirmText,
      onConfirmPressed: () {
        if(onConfirmPressed != null) {
          onConfirmPressed();
        }
      },
    );
    Get.dialog(
      widget,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }


  static void showSimple(
      String title, {
        String content = '',
      }) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: Text(Strings.confirm.tr),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

}