import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnvStore {
  static String get revenueCatGoogleSdkKey => dotenv.env['REVENUE_CAT_GOOGLE_SDK_KEY'] ?? '';
  static String get revenueCatAppleSdkKey => dotenv.env['REVENUE_CAT_APPLE_SDK_KEY'] ?? '';
}