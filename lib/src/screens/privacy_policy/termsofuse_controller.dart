
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../base/base_get_controller.dart';

class TermsOfUseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsOfUseController());
  }
}

class TermsOfUseController extends BaseGetController {

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
        _loadHtmlFromURL();
      },
    );
  }

  _loadHtmlFromURL() async {
    webViewController.loadUrl("https://tmtt.link/termsofuse.html");
  }

}

