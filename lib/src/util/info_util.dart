
import 'package:carrier_info_v3/carrier_info.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:tmtt/src/constants/local_storage_keys.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';

class InfoUtil {

  static Future<String> getAllDeviceInfo() async {

    String result = ""
        "locale: ${Get.deviceLocale.toString()}\n"
        "uuid: ${await getUUid()}\n"
        "platform: ${getPlatform()}\n"
        "carrier: ${await getCarrier()}\n"
        "device model name: ${await getDeviceModelName()}";

    Log.d(result);

    return result;
  }

  static Future<String> getUUid() async {
    var uuid = await LocalStorage.get(Keys.uuid, "");
    if (uuid.isEmpty) {
      var newUuid = const Uuid().v4();
      await LocalStorage.put(Keys.uuid, newUuid);
      uuid = newUuid;
    }
    return uuid;
  }

  static Future<String> getDeviceModelName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(GetPlatform.isWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      return webBrowserInfo.userAgent ?? '';
    } else if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model ?? '';
    } else if (GetPlatform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine ?? '';
    } else {
      return '';
    }
  }

  static Future<String> getCarrier() async {
    var result = '';
    if(GetPlatform.isIOS || GetPlatform.isAndroid) {
      result = await CarrierInfo.carrierName ?? '';
    }
    return result;
  }

  static String getPlatform() {
    if (GetPlatform.isIOS) {
      return "iOS";
    } else if (GetPlatform.isAndroid) {
      return "Android";
    } else if (GetPlatform.isFuchsia) {
      return "Google Fuchsia OS"; // google Fuchsia os
    } else if (GetPlatform.isLinux) {
      return "Linux";
    } else if (GetPlatform.isMacOS) {
      return "MacOS";
    } else if (GetPlatform.isWeb) {
      return "Web";
    } else if (GetPlatform.isWindows) {
      return "Windows";
    } else {
      return "Anonymous OS";
    }
  }

}