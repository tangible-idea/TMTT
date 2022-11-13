import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:tmtt/src/constants/dot_env_store.dart';
import 'package:tmtt/src/util/my_logger.dart';



class Purchase {

  static const String _entitlementId = 'link.tmtt.tmtt';
  static const String _entitlementTestId = 'link.tmtt.tmtt.testflight';

  static Future<void> initPlatformState() async {

    await Purchases.setDebugLogsEnabled(kDebugMode);

    PurchasesConfiguration configuration;
    if (GetPlatform.isAndroid) {
      configuration = PurchasesConfiguration(APIKey.revenueCatGoogleSdkKey);
    } else {
      configuration = PurchasesConfiguration(APIKey.revenueCatAppleSdkKey);
    }
    await Purchases.configure(configuration);
  }

  static Future<void> login(String userId) async {
    await Purchases.logIn(userId);
  }

  static Future<void> setUserEmail(String email) async {
    await Purchases.setEmail(email);
  }

  static Future<void> setUserName(String name) async {
    await Purchases.setDisplayName(name);
  }

  static Future<void> setUserPushToken(String token) async {
    await Purchases.setPushToken(token);
  }

  static Future<String> getUserId() async {
    return await Purchases.appUserID;
  }

  static Future<void> logout() async {
    await Purchases.logOut();
  }

  static Future<CustomerInfo?> getCustomerInfo() async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      Log.d('customerInfo: $customerInfo');
      return customerInfo;
    } on PlatformException catch (e) {
      // Error fetching customer info
      Log.d('error: ${e.message}');
      return null;
    }
  }

  static Future<Offerings?> displayProducts() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      // if (offerings.current != null && offerings.current?.availablePackages.isNotEmpty == true) {
      //   // Display packages for sale
      //   Log.d(offerings);
      // }
      return offerings;
    } on PlatformException catch (e) {
      // optional error handling
      Log.d('error: ${e.message}');
      return null;
    }
  }

  static Future<CustomerInfo?> makePurchase(Package package) async {
    try {
      CustomerInfo purchaserInfo = await Purchases.purchasePackage(package);
      if (purchaserInfo.entitlements.all[_entitlementId]?.isActive == true) {
        // Unlock that great "pro" content
      }
      return purchaserInfo;
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        Log.d(
            'errorCode: $errorCode\n'
                'message: ${e.message}'
        );
      }
      return null;
    }
  }

  static Future<bool> isUserActiveSubscribe(CustomerInfo customerInfo) async {
    return customerInfo.entitlements.all[_entitlementId]?.isActive == true;
  }

}
