import 'package:get/get.dart';

import 'language_en.dart';
import 'language_kr.dart';

class Languages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'ko_KR': translations_kr,
    'en_US': translations_en,
  };
}