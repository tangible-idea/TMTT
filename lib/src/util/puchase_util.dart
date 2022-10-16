import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:tmtt/src/constants/dot_env_store.dart';


Future<void> initPlatformState() async {

  await Purchases.setDebugLogsEnabled(true);

  PurchasesConfiguration configuration;
  if (GetPlatform.isAndroid) {
    configuration = PurchasesConfiguration(DotEnvStore.revenueCatGoogleSdkKey);
  } else {
    configuration = PurchasesConfiguration("public_ios_sdk_key");
  }
  await Purchases.configure(configuration);
}