
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmtt/pages.dart';
import 'package:tmtt/src/constants/local_storage_keys.dart';
import 'package:tmtt/src/screens/base/base_widget.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:tmtt/src/util/my_navigator.dart';

class SplashScreen extends BaseWidget {

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('children!!'),
            SvgPicture.asset('assets/images/splash_logo.svg'),
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    startApp();
  }

  Future startApp() async {

    bool isSetPermission = await LocalStorage.get(Keys.isSetPermission, false);
    Future.delayed(const Duration(milliseconds: 3000), () {
      if(isSetPermission) {

      } else {

      }
      MyNav.pushReplacementNamed(pageName: PageName.home);
    });
  }

}
