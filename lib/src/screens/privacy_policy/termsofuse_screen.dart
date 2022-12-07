
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_app_bar.dart';
import 'package:tmtt/src/screens/base/base_scaffold.dart';
import 'package:tmtt/src/screens/privacy_policy/termsofuse_controller.dart';
import 'package:tmtt/src/util/my_navigator.dart';

class TermsOfUseScreen extends GetView<TermsOfUseController> {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'Terms of use',
        useBackButton: true,
        onBackPressed: () => MyNav.pop(),
      ),
      onPressedAosBackButton: () => MyNav.pop(),
      body: controller.webview(),
    );
  }
}