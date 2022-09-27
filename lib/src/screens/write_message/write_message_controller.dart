
import 'package:get/get.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/src/screens/base/base_get_controller.dart';
import 'package:tmtt/src/util/my_logger.dart';

class WriteMessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WriteMessageController());
  }
}

class WriteMessageController extends BaseGetController {

  @override
  void onInit() {
    Log.d('onInit WriteMessageController');
    // getUserId();
  }

  @override
  void onClose() {
    Log.d('onClose WriteMessageController');
  }

  var userNameObs = "".obs;

  Future<void> getUserId() async {

    String userName = Get.parameters['uid'] ?? '';

    var user = await FireStore.getUser(userName);

    if (user == null) {
      userNameObs.value = 'not found user id';
      return;
    }

    userNameObs.value = "found user id: ${user.userId}";
  }

}