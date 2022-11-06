import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmtt/src/resources/languages/languages_th.dart';

import 'language_en.dart';
import 'language_kr.dart';

class LocaleKey {

  static const ko_KR = "ko_KR";
  static const en_US = "en_US";
  static const th_TH = "th_TH"; // 태국어

  static const koKR = Locale('ko', 'KR');
  static const enUS = Locale('en', 'US');
  static const thTH = Locale('th', 'TH'); // 태국어

}

class Languages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    LocaleKey.ko_KR: translations_kr,
    LocaleKey.en_US: translations_en,
    LocaleKey.th_TH: translations_th,
  };
}