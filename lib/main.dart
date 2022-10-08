import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tmtt/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tmtt/src/screens/index_screen.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:tmtt/src/util/url_strategy_native.dart'
  if (dart.library.html) 'package:tmtt/src/util/url_strategy_web.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // 앱 세로 고정
  if (GetPlatform.isMobile) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // urlConfig();
  runApp(MyTmttApp());
}

class MyTmttApp extends StatelessWidget {

  MyTmttApp({super.key});

  var theme = ThemeData(
    fontFamily: 'Notosans',
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
      unknownRoute: setUnknownPage(), // 404 에러 처리
      initialRoute: setInitialRoute(),
      getPages: kGetPages,
    );
  }

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
