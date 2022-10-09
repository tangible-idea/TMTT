
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_app_bar.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/privacy_policy/privacy_controller.dart';
import 'package:tmtt/src/util/my_navigator.dart';

class PrivacyScreen extends GetView<PrivacyController> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'privacy',
        useBackButton: true,
        onBackPressed: () => MyNav.pop(),
      ),
      onPressedAosBackButton: () => MyNav.pop(),
      body: controller.webview(),
    );
  }
}