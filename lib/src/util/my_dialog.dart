
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/screens/dialog/plain_dialog.dart';

import '../resources/languages/strings.dart';
import '../screens/base/base_dialog_container.dart';

class MyDialog {

  static void showDialog(Widget content) {
    Get.dialog(
      content,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  static void showCupertinoInputDialog() {

  }

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  static void showCupertinoDialog(BuildContext context, Widget child, Color? background) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: background ?? CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ));
  }

  static void showBottom({
        required Widget widget,
        bool isEnableDrag = true,
        bool isFullScreen = false
      }) {
    Get.bottomSheet(
      widget,
      enableDrag: isEnableDrag,
      isScrollControlled: isFullScreen,
      backgroundColor: Colors.white,
      ignoreSafeArea: false,
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