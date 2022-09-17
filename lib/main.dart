import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
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
import 'package:tmtt/src/util/my_logger.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';


void main() {
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

    initFirebase();

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

  void initFirebase() async {

    Log.d('start tmtt app');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    final appCheckToken = await FirebaseAppCheck.instance.getToken();
    Log.d('appCheckToken: $appCheckToken');

    // // Add a new document with a generated ID
    // db.collection("users")
    //     .add(user)
    //     .then((DocumentReference doc) {
    //   Log.d('DocumentSnapshot added with ID: ${doc.id}');
    // });
    //
    // await db.collection("users").get().then((event) {
    //   for (var doc in event.docs) {
    //     Log.d("${doc.id} => ${doc.data()}");
    //   }
    // });
  }

  // Create a new user with a first and last name
  final user = <String, dynamic>{
    "first": "Ada",
    "last": "Lovelace",
    "born": 1815
  };
}
