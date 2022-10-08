
import 'package:carrier_info/carrier_info.dart';
import 'package:get/get.dart';
import 'package:tmtt/data/model/agent.dart';
import 'package:tmtt/data/model/hint.dart';
import 'package:tmtt/data/model/hutils.dart';
import 'package:tmtt/src/constants/local_storage_keys.dart';
import 'package:tmtt/src/network/retrofit_manager.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';

class InfoUtil {

  static Future<Hint> getHint() async {

    var agent = await getDeviceModelInfo();

    var hint = Hint(
      country: '',
      city: '',
      phone: '',
      platform: getPlatform(),
      carrierIsp: await getCarrier(),
    );
    return hint;
  }

  static Future<String> getAllDeviceInfo() async {

    var agent = await getDeviceModelInfo();
    var locationInfo = await getLocationInfo();

    String result = ""
        "city: ${locationInfo.city}\n"
        "country: ${locationInfo.country}\n"
        "carrier: ${locationInfo.isp}\n"
        "uuid: ${await getUUid()}\n"
        "platform: ${getPlatform()}\n"
        "device model name: ${agent.deviceName}\n"
        "os: ${agent.os}\n"
        "os version: ${agent.osVersion}";

    Log.d(result);

    return result;
  }

  static Future<HUtils> getLocationInfo() async {
    var result = await RetrofitManager.retrofitService.getWhoisInfo();
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

  static Future<Agent> getDeviceModelInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if(GetPlatform.isWeb) {
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
        return _analyzeWebAgent(webBrowserInfo.userAgent ?? '');
      } else if (GetPlatform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return Agent(deviceName: androidInfo.model ?? 'android...');
      } else if (GetPlatform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return Agent(deviceName: iosInfo.utsname.machine ?? 'ios...');
      } else {
        return Agent();
      }
    } catch(e) {
      return Agent();
    }
  }

  static Agent _analyzeWebAgent(String agentString) {
    RegExp regExp = RegExp(
      r"\(([^)]+)\)",
      caseSensitive: false,
      multiLine: false,
    );
    if(regExp.hasMatch(agentString) == false) {
      return Agent();
    }
    var agentResult = regExp.firstMatch(agentString)?.group(0)??'';
    var replaced = agentResult.replaceAll('(', '').replaceAll(')', '');
    var array = replaced.split(';');
    Log.d('array: $array');
    try {
      if (array.length == 3) {
        return Agent(
          os: array[0],
          osVersion: array[1],
          deviceName: array[2],
        );
      } else {
        return Agent(
          os: array[0],
          osVersion: array[1],
        );
      }
    } catch(e) {
      return Agent();
    }
  }

  static Future<String> getCarrier() async {
    var result = '';
    if(GetPlatform.isIOS || GetPlatform.isAndroid) {
      try {
        result = await CarrierInfo.carrierName ?? '';
      } catch (e) {
        result = '';
      }
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
      return "Mac OS";
    } else if (GetPlatform.isWeb) {
      return "Web";
    } else if (GetPlatform.isWindows) {
      return "Windows";
    } else {
      return "Anonymous OS";
    }
  }
}
