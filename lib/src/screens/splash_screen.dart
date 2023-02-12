
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmtt/pages.dart';
import 'package:tmtt/src/constants/local_storage_key_store.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/screens/base/base_widget.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:tmtt/src/util/my_navigator.dart';

import '../../generated/assets.dart';

class SplashScreen extends BaseWidget {

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.kPrimary,
      body: Stack(children: [
          SvgPicture.asset(Assets.imagesSplashRippes),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.imagesHello),
                Image.asset(Assets.imagesTmttLogoWhite36),
              ],
            ),
          ),
        ]),
    );
  }

  @override
  void onInit() {
    startApp();
  }

  Future startApp() async {
    bool isSetPermission = await LocalStorage.get(KeyStore.isLogin, false);
    Future.delayed(const Duration(milliseconds: 3000), () {
      if(isSetPermission) {
        // MyNav.pushReplacementNamed(pageName: PageName.home);
        MyNav.pushReplacementNamed(pageName: "/tangibleidea");
      } else {
        MyNav.pushReplacementNamed(pageName: PageName.register);
      }
    });
  }

}
