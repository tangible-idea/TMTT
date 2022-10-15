


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tmtt/firebase/fire_store.dart';
import 'package:tmtt/pages.dart';
import 'package:tmtt/src/constants/local_storage_keys.dart';
import 'package:tmtt/src/util/local_storage.dart';
import 'package:tmtt/src/util/my_logger.dart';
import 'package:tmtt/src/util/my_navigator.dart';

import '../base/base_get_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}

class RegisterController extends BaseGetController {


  late final inputController = TextEditingController();

  @override
  void onInit() {
  }

  @override
  void onClose() { }

  void goToHome() {
    MyNav.pushReplacementNamed(
      pageName: PageName.home,
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  void register() async {
    var userId = inputController.text;

    FlutterInsta flutterInsta = FlutterInsta();
    await flutterInsta.getProfileData(userId);
    Log.d(
        flutterInsta.username + '\n' +
            flutterInsta.followers + '\n' +
            flutterInsta.following + '\n' +
            flutterInsta.imgurl
    );

    var registerDocId = await FireStore.register(userId);
    await LocalStorage.put(Keys.userInstagramId, userId);
    await LocalStorage.put(Keys.userDocId, registerDocId);
    await LocalStorage.put(Keys.isLogin, true);

    Log.d('success register');
    MyNav.pushReplacementNamed(
      pageName: PageName.home,
    );
  }
}

