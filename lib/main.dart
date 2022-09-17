import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:tmtt/pages.dart';
import 'package:tmtt/src/screens/dynamic/ArticlePage.dart';
import 'package:tmtt/src/screens/home/home_screen.dart';
import 'package:tmtt/src/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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



    // 앱 세로 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return GetMaterialApp(
      title: 'TMTT',
      theme: theme,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      locale: Get.deviceLocale, // 언어 설정
      initialRoute: PageName.splash,
      onGenerateRoute: RouteConfiguration.onGenerateRoute,
      routes: {
        OverviewPage.route: (context) => OverviewPage(),
      },
      getPages: kGetPages,
    );
  }
}
