import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tmtt/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tmtt/src/resources/languages/languages.dart';
import 'package:tmtt/src/screens/index_screen.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:tmtt/src/util/url_strategy_native.dart'
  if (dart.library.html) 'package:tmtt/src/util/url_strategy_web.dart';

import 'package:tmtt/src/util/register_webview.dart'
  if (dart.library.html) 'package:tmtt/src/util/register_web_webview.dart';

import 'src/util/inapp_purchase_util.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // 앱 세로 고정
  if (!GetPlatform.isWeb && GetPlatform.isAndroid || GetPlatform.isIOS) {
    await dotenv.load(fileName: ".env");
    await Purchase.initPlatformState();
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // urlConfig();
  registerWebViewWebImplementation();
  runApp(MyTmttApp());
}

class MyTmttApp extends StatelessWidget {

  MyTmttApp({super.key});

  var theme = ThemeData(
    fontFamily: window.locale.languageCode == "en" ? "Rubik" : "NanumSquareRound",
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {

    // initFirebase();

    return GetMaterialApp(
      title: 'TMTT',
      theme: theme,
      locale: Get.deviceLocale, // 언어 설정
      fallbackLocale: const Locale('en', 'US'), // 잘못된 지역이 선택된 경우 복구될 지역을 지정
      // supportedLocales: supportedLocale,
      translations: Languages(), // 로컬라이징 적용
      unknownRoute: setUnknownPage(), // 404 에러 처리
      initialRoute: setInitialRoute(),
      getPages: kGetPages,
    );
  }

  // supported locale 태국어, 베트남어, 인니어, 말레이어, 일본어, 중국어, 영어, 한국어
  List<Locale> supportedLocale = const [
    Locale('ko', 'KR'),
    Locale('en', 'US'),
    Locale('th', 'TH'), // 태국어
  ];

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
