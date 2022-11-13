
import 'package:get/get.dart';
import '../resources/languages/languages.dart';

class LanguageUtil {
  void updateAppLanguage(String language) {
    switch(language.toLowerCase()) {
      case "korean": case "kr": case "ko":
        Get.updateLocale(LocaleKey.koKR); break;
      case "english": case "en": case "us":
        Get.updateLocale(LocaleKey.enUS); break;
      case "thai": case "th":
        Get.updateLocale(LocaleKey.thTH); break;
    }

  }
}