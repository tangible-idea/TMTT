

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/util/my_logger.dart';


abstract class BaseGetController extends FullLifeCycleController with FullLifeCycleMixin {
  String currentRoute() => Get.currentRoute;

  @override
  void onInit() {
    Log.d('onInit: ${currentRoute()}');
    super.onInit();
  }

  @override
  void onClose() {
    Log.d('onClose: ${currentRoute()}');
    super.onClose();
  }

  @override
  void onDetached() {
    Log.d('onDetached: ${currentRoute()}');
  }

  @override
  void onInactive() {
    Log.d('onInactive: ${currentRoute()}');
  }

  @override
  void onPaused() {
    Log.d('onPaused: ${currentRoute()}');
  }

  @override
  void onResumed() {
    Log.d('onResumed: ${currentRoute()}');
  }

  void onNextPressed() {  }
  void onBackPressed() {  }
  void onCancelPressed() {  }

  void showLoading({String msg = 'Loading...'}) {
    EasyLoading.show(status: msg, maskType: EasyLoadingMaskType.black);
  }

  void dismissLoading() {
    EasyLoading.dismiss();
  }
}
