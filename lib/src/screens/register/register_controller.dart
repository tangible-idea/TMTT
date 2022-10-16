


import 'dart:ffi';

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

import '../../util/my_snackbar.dart';
import '../base/base_get_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}

class RegisterController extends BaseGetController {


  late final slugInputController = TextEditingController();

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


  void createYourSlug(String slug) async {
    if(slug.isEmpty) { // TODO: validation
      MySnackBar.show(title: 'Error', message: 'Please input a valid slug.');
      return;
    }
    bool isSuccess= await FireStore.updateUserValue("slug", slug);
    if(!isSuccess) {
      MySnackBar.show(title: 'Error', message: 'There is an error while creating your slug.');
    }
  }


  void signInWithGoogle() async {
    try {
      UserCredential credential= await getCredentialFromGoogleFirebase();
      String userEmail= credential.user?.email.toString() ?? "";
      MySnackBar.show(title: 'Login', message: userEmail);

      var registerDocId = "";

      // If there's no user : signing-up.
      var currentUser= await FireStore.searchUser(userEmail);
      if(currentUser == null) {
        registerDocId= await FireStore.register(userEmail); // firestore signing up.
      }else{ // user does exist : get current doc-id.
        registerDocId= currentUser.documentId;
      }

      await LocalStorage.put(Keys.userInstagramId, userEmail);
      await LocalStorage.put(Keys.userDocId, registerDocId);
      await LocalStorage.put(Keys.isLogin, true);

      // TODO: firestore -> slug값이 없으면
      if(currentUser == null) {
        // Go to home
        MyNav.pushReplacementNamed(
          pageName: PageName.createslug,
        );
      }else{
        // Go to home
        //goToHome();
        MyNav.pushReplacementNamed(
          pageName: PageName.createslug,
        );
      }


    }catch(e) {
      MySnackBar.show(title: 'Exception', message: e.toString());

    }
}


  Future<UserCredential> getCredentialFromGoogleFirebase() async {
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
    var userId = slugInputController.text;

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

