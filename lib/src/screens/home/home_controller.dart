
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_get_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends BaseGetController {

  @override
  void onInit() {

  }

  @override
  void onClose() {

  }

  @override
  void onBackPressed() {

  }

  @override
  void onNextPressed() {

  }

}