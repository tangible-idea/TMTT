
import 'package:get/get.dart';
import 'package:tmtt/src/screens/base/base_get_controller.dart';
import 'package:tmtt/src/util/my_logger.dart';

class DynamicUserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DynamicUserController());
  }
}

class DynamicUserController extends BaseGetController {

  @override
  void onInit() {
    Log.d('onInit DynamicUserController');
  }

  @override
  void onClose() {
    Log.d('onClose DynamicUserController');
  }

  String getUserId() {
    String userName = Get.parameters['uid'] ?? '';
    if(userName.isEmpty) {
      return 'null user id';
    } else {
      return userName;
    }
  }

}