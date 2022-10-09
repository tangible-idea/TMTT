

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dart:typed_data';


import '../base/base_get_controller.dart';

class PrivacyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyController());
  }
}

class PrivacyController extends BaseGetController {

  late WebViewController webViewController;

  @override
  void onInit() { }

  @override
  void onClose() { }

  Widget webview() {
    return WebView(
      initialUrl: 'about:blank',
      onWebViewCreated: (WebViewController webViewController) {
        this.webViewController = webViewController;
        _loadHtmlFromAssets();
      },
    );
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString(Assets.wwwPrivacypolicy);
    webViewController.loadUrl( Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }

}

