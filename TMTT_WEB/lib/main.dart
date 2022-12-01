import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tmtt_web/pages.dart';

import 'constants/languages.dart';
import 'index_screen.dart';

void main() {
  runApp(const MyApp());
}

var themeMulti = ThemeData(
  fontFamily: "NanumSquareRound",
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
        GetMaterialApp(
          title: 'TMTT',
          theme: themeMulti,
          locale: Get.deviceLocale, // 언어 설정
          fallbackLocale: const Locale('en', 'US'), // 잘못된 지역이 선택된 경우 복구될 지역을 지정
          // supportedLocales: supportedLocale,
          translations: Languages(), // 로컬라이징 적용
          unknownRoute: setUnknownPage(), // 404 에러 처리
          initialRoute: setInitialRoute(),
          getPages: kGetPages,
        ),
    );
  }
}

String setInitialRoute() {
  return PageName.index;
}

GetPage setUnknownPage() {
  return BaseGetPage(
      name: PageName.index,
      page: () => IndexScreen()
  );
}
