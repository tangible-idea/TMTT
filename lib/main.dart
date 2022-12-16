import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flarelane_flutter/flarelane_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tmtt/firebase/fcm_service.dart';
import 'package:tmtt/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tmtt/src/constants/app_secret.dart';
import 'package:tmtt/src/constants/local_storage_key_store.dart';
import 'package:tmtt/src/resources/languages/languages.dart';
import 'package:tmtt/src/screens/index_screen.dart';
import 'package:tmtt/src/util/language_util.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:tmtt/src/util/url_strategy_native.dart'
  if (dart.library.html) 'package:tmtt/src/util/url_strategy_web.dart';

import 'package:tmtt/src/util/register_webview.dart'
  if (dart.library.html) 'package:tmtt/src/util/register_web_webview.dart';

import 'src/util/inapp_purchase_util.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // 앱 세로 고정
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Purchase.initPlatformState();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // urlConfig();
  registerWebViewWebImplementation();

  // ensureInitialized() 이후 초기화 코드가 실행되도록 합니다
  //WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  // 다음 초기화 코드 입력 with FlareLane project ID.
  FlareLane.shared.initialize(AppSecret.FLARELANE_PROEJCT_ID);
  FlareLane.shared.setLogLevel(LogLevel.verbose);

  var myapp= MyTmttApp();
  MyTmttApp.loadMyLanguage();
  runApp(myapp);
}


class MyTmttApp extends StatelessWidget {

  MyTmttApp({super.key});

  var themeEN = ThemeData(
    fontFamily: "Rubik",
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
  );

  var themeMulti = ThemeData(
    fontFamily: "NanumSquareRound",
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
  );

  //var currLang = Get.locale!.languageCode.obs;
  static final _currLang = "English".obs;

  static Future<void> loadMyLanguage() async {
    final String language = await LocalStorage.get(KeyStore.language, '');
    if(language.isNotEmpty) {
      _currLang.value= language;
      LanguageUtil().updateAppLanguage(language);
    } else {  // 유저가 수동으로 세팅한 언어설정이 없으면 -> 기기 설정으로 세팅.
      _currLang.value= Get.locale!.languageCode.toString();
      LanguageUtil().updateAppLanguage(_currLang.value);
    }
  }

  @override
  Widget build(BuildContext context) {

    FcmService.init();

    return Obx(()=>
      GetMaterialApp(
        title: 'TMTT',
        theme: _currLang.value == "Korean" ? themeMulti : themeEN,
        locale: Get.deviceLocale, // 언어 설정
        fallbackLocale: const Locale('en', 'US'), // 잘못된 지역이 선택된 경우 복구될 지역을 지정
        // supportedLocales: supportedLocale,
        translations: Languages(), // 로컬라이징 적용
        unknownRoute: setUnknownPage(), // 404 에러 처리
        initialRoute: setInitialRoute(),
        getPages: kGetPages,
        builder: EasyLoading.init(),
      ),
    );
  }

  // supported locale 태국어, 베트남어, 인니어, 말레이어, 일본어, 중국어, 영어, 한국어
  // List<Locale> supportedLocale = const [
  //   Locale('ko', 'KR'),
  //   Locale('en', 'US'),
  //   Locale('th', 'TH'), // 태국어
  // ];

  String setInitialRoute() {
    if(GetPlatform.isWeb) {
      return PageName.index;
    } else if(GetPlatform.isAndroid || GetPlatform.isIOS) {
      return PageName.splash;
    } else {
      return PageName.index;
    }
  }

  GetPage setUnknownPage() {
    return BaseGetPage(
        name: PageName.index,
        page: () => IndexScreen()
    );
  }

  void initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // final appCheckToken = await FirebaseAppCheck.instance.getToken();
    // Log.d('appCheckToken: $appCheckToken');

  }
}
